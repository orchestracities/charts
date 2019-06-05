#!/bin/sh

echo "git push"
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git checkout gh-pages -b $TRAVIS_PULL_REQUEST
docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.9.0 repo index . --url https://orchestracities.github.io/charts/
git push origin $TRAVIS_PULL_REQUEST
git merge origin/gh-pages
