#!/bin/sh
echo "git push"
echo "PR - ${TRAVIS_PULL_REQUEST}"
rm -rf charts
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git checkout gh-pages
git checkout -b "PR-${TRAVIS_PULL_REQUEST}" gh-pages
docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.9.0 repo index . --url https://orchestracities.github.io/charts/
git add --all && git commit -m "PR - ${TRAVIS_PULL_REQUEST} update"
git "https://${GITHUB_TOKEN}@${GH_REPO}" "PR-${TRAVIS_PULL_REQUEST}" > /dev/null 2>&1
#git merge origin/gh-pages
