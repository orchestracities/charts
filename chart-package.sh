#!/bin/bash
FILES=./charts/*

mkdir local

docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.16.9 init

for f in $FILES
do
  echo "Processing $f chart..."
  docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.16.9 package $f --destination /apps
done

rm -rf local
