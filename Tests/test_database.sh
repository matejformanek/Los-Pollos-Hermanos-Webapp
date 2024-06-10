#!/bin/bash

values=($(echo "$DB_CONNECTION_STRING" | sed "s/[^=]*='\([^']*\)'/\1 /g"));

cd Database_tests || exit 1;

echo "" > database_log.txt

export PGPASSWORD="${values[2]}";

test_passed=0;

for file in *.sql; do
  hold=$(psql -h "${values[3]}" -p "${values[4]}" -U "${values[1]}" "${values[0]}" -f "$file" | grep psql)
  echo -n "$hold";

  if [[ "$hold" == *ERROR* ]]; then
        echo "psql command failed for file: $file"
        echo -n "$hold" >> database_log.txt
        test_passed=1
  fi
done

exit $test_passed;