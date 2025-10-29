# WINDOW FUNCTIONS

* 10 SQL Window Functions Every App Dev Should Know. [link](https://medium.com/@connect.hashblock/10-sql-window-functions-every-app-dev-should-know-1491bd5fbde8)

```sql
CREATE TABLE orders (
  id            BIGSERIAL PRIMARY KEY,
  user_id       BIGINT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL,
  amount_cents  INTEGER NOT NULL,
  status        TEXT CHECK (status IN ('pending','paid','refunded'))
);
```

## 1) ROW_NUMBER() - Deterministic Pagination & De-duplication

**When to use**: numbered rows within a group; remove duplicates but keep the "best" row.

```sql
SELECT *
FROM (
  SELECT o.*,
         ROW_NUMBER() OVER (
           PARTITION BY user_id
           ORDER BY created_at DESC, id DESC
         ) AS rn
  FROM orders o
) t
WHERE rn <= 10; -- last 10 orders per user
```

**Why it’s great**: app-friendly pagination that doesn’t drift when new rows arrive (tie-break by id). For de-dupe, swap the filter: WHERE rn = 1.

## 2) RANK() — Leaderboards With Gaps

**When to use**: public leaderboards where ties share the same rank and gaps appear (1,1,3…).

```sql
SELECT user_id,
       SUM(amount_cents) AS revenue,
       RANK() OVER (ORDER BY SUM(amount_cents) DESC) AS revenue_rank
FROM orders
WHERE status = 'paid'
GROUP BY user_id;
```

**Why it’s great**: matches users’ mental model of "shared rank = tied."

## 3) DENSE_RANK() — Leaderboards Without Gaps

**When to use**: marketing dashboards that want 1,1,2 (no gaps).

```sql
DENSE_RANK() OVER (ORDER BY SUM(amount_cents) DESC) AS revenue_dense_rank
```

**Pro tip**: Use DENSE_RANK when you plan to prize "Top 3" and don’t want fewer than three winners due to ties.

## 4) NTILE(n) — Bucketing Users Into Percentiles/Quartiles

**When to use**: segment users into n equal groups (e.g., top 25%).

```sql
SELECT user_id,
       SUM(amount_cents) AS revenue,
       NTILE(4) OVER (ORDER BY SUM(amount_cents)) AS quartile
FROM orders
GROUP BY user_id;
```

**UI pattern**: "You’re in the top quartile of spenders this month."

## 5) LAG() — Compare to Previous Row (Churn & Deltas)

**When to use**: compute day-over-day, event-to-event differences.

```sql
WITH daily AS (
  SELECT date_trunc('day', created_at) AS day,
         SUM(amount_cents) AS revenue
  FROM orders
  WHERE status = 'paid'
  GROUP BY 1
)
SELECT day,
       revenue,
       LAG(revenue) OVER (ORDER BY day) AS prev_revenue,
       revenue - LAG(revenue) OVER (ORDER BY day) AS delta
FROM daily
ORDER BY day;
```

**Why it’s great**: fuels sparkline deltas like "+12% vs yesterday" without self-joins.

## 6) LEAD() — Peek Ahead (SLA Windows, Upcoming Events)

**When to use**: compute the next event’s timestamp or range.

```sql
SELECT id,
       created_at,
       LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at) AS next_order_at
FROM orders
WHERE user_id = $1;
```

**Product hook**: "Users typically reorder within X days."

## 7) FIRST_VALUE() — Pin the Baseline

**When to use**: compare each row to the first value in the partition.

```sql
SELECT user_id, created_at, amount_cents,
       FIRST_VALUE(amount_cents) OVER (
         PARTITION BY user_id
         ORDER BY created_at
       ) AS first_amount
FROM orders;
```

**Pattern**: show "price changed since first purchase."

## 8) LAST_VALUE() — Track the Latest (with a proper frame)

**The gotcha**: by default many engines’ window frame for `ORDER BY` is
`RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`, so `LAST_VALUE` equals the current row unless you extend the frame.

```sql
SELECT user_id, created_at, amount_cents,
       LAST_VALUE(amount_cents) OVER (
         PARTITION BY user_id
         ORDER BY created_at
         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS latest_amount
FROM orders;
```

**Use case**: show each row alongside "latest known value."

## 9) SUM() OVER — Running Totals & Cumulative Funnels

**When to use**: cumulative revenue, on-boarding progress, or quota burn.

```sql
SELECT created_at::date AS day,
       SUM(amount_cents) AS revenue,
       SUM(SUM(amount_cents)) OVER (
         ORDER BY created_at::date
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_revenue
FROM orders
WHERE status = 'paid'
GROUP BY day
ORDER BY day;
```

**Why it’s great**: a single pass yields both daily and cumulative series for charts.

## 10) AVG() OVER — Moving Averages That Don’t Lie

**When to use**: smooth volatile time series in-database (7-day moving average).

```sql
WITH daily AS (
  SELECT date_trunc('day', created_at) AS day,
         SUM(amount_cents) AS revenue
  FROM orders
  WHERE status = 'paid'
  GROUP BY 1
)
SELECT day,
       revenue,
       AVG(revenue) OVER (
         ORDER BY day
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS ma7
FROM daily
ORDER BY day;
```

**Frame choice matters**: `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` ensures exactly 7 points—clean math and predictable edges.

---

## Frames, Partitions, and Performance: A Fast Mental Model

* **PARTITION BY** = "per group." Think of it as resetting counters.
* **ORDER BY** (inside OVER) = "timeline within the group."
* **FRAME** = "which neighbors are visible to this calculation."
* Default is often `RANGE UNBOUNDED PRECEDING` to `CURRENT ROW`, which is value-based and can surprise you; most app analytics prefer `ROWS` frames for exact counts.

**Indexing**:

* Add indexes that match your window’s `PARTITION BY` and `ORDER BY` to reduce sort/scan cost, e.g., `CREATE INDEX ON orders (user_id, created_at, id);`
* For time windows, clustered storage (or at least an index on created_at) helps a lot.

**Cardinality sanity**:

* If each partition is huge (e.g., all rows per global user), consider bucketing by time: `PARTITION BY user_id, date_trunc('month', created_at)` when appropriate.
