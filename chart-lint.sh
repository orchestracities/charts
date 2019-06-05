#!/bin/bash
FILES=./charts/*

for f in $FILES
do
  echo "Processing $f chart..."
  docker run -ti --rm -v $(pwd):/apps alpine/helm:2.9.0 lint $f
done
