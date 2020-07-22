#!/bin/bash
FILES=./charts/*

for f in $FILES
do
  echo "Processing $f chart ..."
  docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.16.9 template $f
done

rm -rf local
