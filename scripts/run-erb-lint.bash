#!/usr/bin/env bash

set -e

cd "${0%/*}/.."

echo "Running ERB lint"
bundle exec erblint --lint-all
