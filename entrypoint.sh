#!/bin/sh

set -e


if [ -z "$ACCESS_TOKEN" ]
then
  echo "You must provide the action with the GitHub Token secret in order to deploy."
  exit 1
fi

if [ -z "$BRANCH" ]
then
  echo "You must provide the action with a branch name it should deploy to, for example gh-pages or main"
  exit 1
fi


if [ -z "$BUILD_DIR" ]
then
  echo "You must provide the action with the folder name in the repository where your compiled page lives."
  exit 1
fi

if [ -z "$REPO" ]
then
  echo "You must provide a repository here, for example $GITHUB_ACTOR.github.io.git "
  exit 1
fi


case "$BUILD_DIR" in /*|./*)
  echo "The deployment folder cannot be prefixed with '/' or './'. Instead reference the folder name directly."
  exit 1
esac


# Builds the project if a build script is provided.
echo "Running build scripts... $BUILD_SCRIPT" && \
eval "$BUILD_SCRIPT" && \

echo "#################################################"
echo "Changing directory to 'BUILD_DIR' $BUILD_DIR ..."
cd $BUILD_DIR

echo "#################################################"
echo "Now deploying to GitHub Pages..."
REMOTE_REPO="https://${ACCESS_TOKEN}@github.com/${GITHUB_ACTOR}/${REPO}" && \
git init && \
git config user.name "${GITHUB_ACTOR}" && \
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" && \
if [ -z "$(git status --porcelain)" ]; then
    echo "Nothing to commit" && \
    exit 0
fi && \
git add . && \

git commit -m "Deployed form $GITHUB_REPOSITORY :rocket:" && \
git push --force $REMOTE_REPO master:$BRANCH && \
rm -fr .git && \
cd $GITHUB_WORKSPACE && \
echo "Content of $BUILD_DIR has been deployed to your $REMOTE_REPO"
