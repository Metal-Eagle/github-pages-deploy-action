#!/bin/sh

set -e

# Builds the project if a build script is provided.
echo "Running build scripts... $BUILD_SCRIPT" && \
eval "$BUILD_SCRIPT" && \

echo "#################################################"
echo "Changing directory to 'BUILD_DIR' $BUILD_DIR ..."
cd $BUILD_DIR

echo "#################################################"
echo "Now deploying to GitHub Pages..."
REMOTE_REPO="https://${ACCESS_TOKEN}@github.com/${GITHUB_ACTOR}/${GITHUB_ACTOR}.github.io.git" && \

fi && \
git init && \
git config user.name "${GITHUB_ACTOR}" && \
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" && \
if [ -z "$(git status --porcelain)" ]; then
    echo "Nothing to commit" && \
    exit 0
fi && \
git add . && \
git commit -m 'Deploy to GitHub Pages' && \
git push --force $REMOTE_REPO master:master && \
rm -fr .git && \
cd $GITHUB_WORKSPACE && \
echo "Content of $BUILD_DIR has been deployed to GitHub Pages."
