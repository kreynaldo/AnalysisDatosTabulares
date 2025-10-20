#!/usr/bin/env python3
import re
import csv
import os

def parse_sql_value(value):
    """Parse a SQL value and convert it to a proper Python value."""
    value = value.strip()

    # NULL values
    if value.upper() == 'NULL':
        return ''

    # Remove quotes from strings
    if value.startswith("'") and value.endswith("'"):
        # Unescape single quotes
        return value[1:-1].replace("''", "'")

    # Binary data (\\x...)
    if value.startswith("'\\x") or value.startswith('\\x'):
        return '[BINARY]'

    # Return as is for numbers and other types
    return value

def parse_values_line(line):
    """Parse a VALUES line and extract individual rows."""
    # Remove the leading tab/spaces and trailing comma/semicolon
    line = line.strip().rstrip(',;')

    # Match rows in the format (val1, val2, val3, ...)
    rows = []
    row_pattern = r'\(([^)]+(?:\([^)]*\)[^)]*)*)\)'

    matches = re.finditer(row_pattern, line)
    for match in matches:
        row_content = match.group(1)
        # Split by comma, but respect quoted strings
        values = []
        current_value = ''
        in_quotes = False
        paren_depth = 0

        i = 0
        while i < len(row_content):
            char = row_content[i]

            if char == "'" and (i == 0 or row_content[i-1] != '\\'):
                in_quotes = not in_quotes
                current_value += char
            elif char == '(' and not in_quotes:
                paren_depth += 1
                current_value += char
            elif char == ')' and not in_quotes:
                paren_depth -= 1
                current_value += char
            elif char == ',' and not in_quotes and paren_depth == 0:
                values.append(parse_sql_value(current_value))
                current_value = ''
                i += 1
                continue
            else:
                current_value += char

            i += 1

        # Don't forget the last value
        if current_value:
            values.append(parse_sql_value(current_value))

        if values:
            rows.append(values)

    return rows

def extract_sql_to_csv(sql_file):
    """Extract data from SQL file to CSV files."""
    current_table = None
    csv_writers = {}
    csv_files = {}

    with open(sql_file, 'r', encoding='utf-8') as f:
        for line in f:
            # Check if this is an INSERT INTO line
            insert_match = re.match(r'INSERT INTO (?:public\.)?(\w+) VALUES', line)
            if insert_match:
                current_table = insert_match.group(1)
                print(f"Processing table: {current_table}")

                # Create CSV file for this table
                csv_path = f'csv/{current_table}.csv'
                csv_files[current_table] = open(csv_path, 'w', newline='', encoding='utf-8')
                csv_writers[current_table] = csv.writer(csv_files[current_table])
                continue

            # If we're currently processing a table, parse the VALUES
            if current_table and line.strip() and not line.strip().startswith('--'):
                rows = parse_values_line(line)
                for row in rows:
                    csv_writers[current_table].writerow(row)

                # Check if this is the end of the INSERT statement (ends with ;)
                if line.rstrip().endswith(';'):
                    current_table = None

    # Close all CSV files
    for f in csv_files.values():
        f.close()

    print(f"\nExtracted {len(csv_files)} tables to CSV files in the 'csv/' directory")

if __name__ == '__main__':
    extract_sql_to_csv('northwind_data.sql')
