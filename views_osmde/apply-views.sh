#!/bin/bash

function die_usage() {
  echo "usage: apply-views.sh database ?lang?" >&2
  exit 1
}

if [ $# -gt 2 ]; then
  die_usage
fi

if [ $# -lt 1 ]; then
  die_usage
fi

if [ $# -eq 2 ]; then
  lang=$2
else
  lang='de'
fi

echo "using database: $1"
echo "using language: $lang"

pushd $(dirname "$0") >/dev/null
psql -f ../osm_tag2num.sql $1

for view in view-*.sql; do
  sed -e "s/'de'/'$lang'/g" $view >/tmp/$view
  psql -f /tmp/$view $1
  rm -f /tmp/$view
done

