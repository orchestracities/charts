#!/bin/bash
FILES=./charts/*

for f in $FILES
do
  echo "Processing $f chart..."
  output=$(docker run -ti --rm -v $(pwd):/apps alpine/helm:2.9.0 lint $f 2>&1)
  ret=$?

  if [[ $ret -eq 0 ]]; then
      echo $output
  else
      if [[ $output == *'error'* ]]; then
           echo $output
           exit 1
      else
           echo $output
      fi
  fi
done
