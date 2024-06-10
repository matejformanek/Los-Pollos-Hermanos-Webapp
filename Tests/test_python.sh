#!/bin/bash

cd Python_unit_tests || exit 1;

echo "" > python_log.txt

test_passed=0;

for file in *.py; do
  pytest "$file"

  if [ $? -ne 0 ]; then
    echo "python test failed for file: $file"
    pytest "$file" >> python_log.txt
    test_passed=1
  fi
done

exit $test_passed;