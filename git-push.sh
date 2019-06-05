#!/bin/sh
echo "creating gh-pages branch for PR - ${TRAVIS_PULL_REQUEST}"
rm -rf charts
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
echo "1. checkout gh-pages"
git checkout gh-pages
echo "2. new branch"
git checkout -b "PR-${TRAVIS_PULL_REQUEST}" gh-pages
echo "3. update index"
docker run -ti --rm -v $(pwd):/apps -v $(pwd)/local:/root/.helm/repository/local alpine/helm:2.9.0 repo index . --url https://orchestracities.github.io/charts/
echo "4. commit changes"
git add --all && git commit -m "PR - ${TRAVIS_PULL_REQUEST} update"
echo "5. push to new brach on remote"
git push "https://${GITHUB_TOKEN}@${GH_REPO}" "PR-${TRAVIS_PULL_REQUEST}" > /dev/null 2>&1
#git merge origin/gh-pages
