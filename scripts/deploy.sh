#!/bin/bash

set -e # exit with nonzero exit code if anything fails

if [[ $TRAVIS_BRANCH == "dev" && $TRAVIS_PULL_REQUEST == "false" ]]; then

#go to home and setup git
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis"

#using token clone gh-pages branch
git clone --quiet --branch=master https://${GH_TOKEN}@github.com/${GH_USER}/${GH_REPO}.git > /dev/null

#go into directory and copy data we're interested in to that directory
cd ${GH_REPO}
cp -Rf $HOME/dist/* .

#add, commit and push files
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER"
git push -fq origin master > /dev/null

fi;