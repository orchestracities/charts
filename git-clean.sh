#!/bin/sh
git config --replace-all remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
git fetch
for branch in $(git branch -r|grep -v HEAD) ; do
    git checkout ${branch#origin/}
done