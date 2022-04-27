#!/usr/bin/env bash

echo "Running pre-commit hook"

./scripts/run-rubocop.bash

if [ $? -ne 0 ]; then
  cat <<\EOF

Error: Rubocop must pass before committing
EOF
 exit 1
fi

./scripts/run-erb-lint.bash

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
  cat <<\EOF

Error: ERB lint must pass before committing
EOF
  exit 1
fi
