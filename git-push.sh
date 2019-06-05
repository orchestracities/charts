#!/bin/sh
echo "git push"
echo "PR - ${TRAVIS_PULL_REQUEST}"
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git checkout gh-pages
git checkout -b "PR-${TRAVIS_PULL_REQUEST}" gh-pages
docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.9.0 repo index . --url https://orchestracities.github.io/charts/
git add --all && git commit -m "PR - ${TRAVIS_PULL_REQUEST} update"
git push origin "PR-${TRAVIS_PULL_REQUEST}"
#git merge origin/gh-pages
