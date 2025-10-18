
Northwind sample database

Install the PostgreSQL-compatible version of the Northwind dataset on the YugabyteDB distributed SQL database.

You can install and use the Northwind sample database using:

    A local installation of YugabyteDB. To install YugabyteDB, refer to Quick Start.
    Using cloud shell or a client shell to connect to a cluster in YugabyteDB Aeon. Refer to Connect to clusters in YugabyteDB Aeon. To get started with YugabyteDB Aeon, refer to Quick Start.

In either case, you use the YugabyteDB SQL shell (ysqlsh) CLI to interact with YugabyteDB using YSQL.
About the Northwind sample database

The Northwind database is a sample database that was originally created by Microsoft and used as the basis for their tutorials in a variety of database products for decades. The Northwind database contains the sales data for a fictitious company called “Northwind Traders,” which imports and exports specialty foods from around the world. The Northwind database is an excellent tutorial schema for a small-business ERP, with customers, orders, inventory, purchasing, suppliers, shipping, employees, and single-entry accounting. The Northwind database has since been ported to a variety of non-Microsoft databases, including PostgreSQL.

The Northwind dataset includes sample data for the following.

    Suppliers: Suppliers and vendors of Northwind
    Customers: Customers who buy products from Northwind
    Employees: Employee details of Northwind traders
    Products: Product information
    Shippers: The details of the shippers who ship the products from the traders to the end-customers
    Orders and Order_Details: Sales Order transactions taking place between the customers & the company

The Northwind sample database includes 14 tables and the table relationships are showcased in the following entity relationship diagram.

https://docs.yugabyte.com/preview/sample-data/northwind/
