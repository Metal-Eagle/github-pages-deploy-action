FROM node:12.19-alpine3.12

LABEL "com.github.actions.name"="Deploy to GitHub Pages"
LABEL "com.github.actions.description"="This action will handle the building and deploying process of your project to GitHub Pages."
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="https://github.com/Metal-Eagle/github-pages-deploy-action"
LABEL "homepage"="https://github.com/Metal-Eagle/github-pages-deploy-action"
LABEL "maintainer"="Metal-Eagle"

# hadolint ignore=DL3018
RUN apk --no-cache add \
	git \
	jq

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
