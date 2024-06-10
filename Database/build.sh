#!/bin/bash

if [ -z "$4" ]; then
    echo "Missing some arguments";
    echo "Command like: ./build.sh DB_HOST DB_PORT DB_NAME DB_USER";
    exit 1;
fi

# PostgreSQL connection parameters
DB_HOST="$1";
DB_PORT="$2";
DB_NAME="$3";
DB_USER="$4";

echo -n "Enter password for $DB_USER: ";
read -rs DB_PASSWORD;
export PGPASSWORD="$DB_PASSWORD"

# Connect to PostgreSQL and run SQL Drop files
for file in "$(pwd)/Drop"/*.sql; do
    echo "Executing $file...";
    psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" -f "$file"
done;

for file in "$(pwd)/Create"/*.sql; do
    echo "Executing $file...";
    psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" -f "$file"
done;

for file in "$(pwd)/Insert"/*.sql; do
    echo "Executing $file...";
    psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" -f "$file"
done;

for file in "$(pwd)/Routines"/*.sql; do
    echo "Executing $file...";
    psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" -f "$file"
done;