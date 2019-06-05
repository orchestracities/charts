#!/bin/sh
echo "creating gh-pages branch for PR - ${TRAVIS_PULL_REQUEST}"
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
echo "1. checkout gh-pages"
git checkout gh-pages
rm -rf charts
echo "2. update index"
docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.9.0 repo index . --url https://orchestracities.github.io/charts/
echo "3. commit changes"
git add --all && git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"
echo "4. fix remote"
git remote add origin-pages "https://${GITHUB_TOKEN}@github.com/orchestracities/charts.git" > /dev/null 2>&1
echo "5. push to gh-pages"
git push --quiet --set-upstream origin-pages gh-pages