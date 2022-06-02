#!/bin/bash

function die_usage() {
  echo "usage: apply-views.sh database" >&2
  exit 1
}

if [ $# -ne 1 ]; then
  die_usage
fi

echo "using database: $1"

pushd $(dirname "$0") >/dev/null

for view in view-*.sql; do
  psql -f $view $1
done

