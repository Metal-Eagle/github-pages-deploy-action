# Deploy to your user of organization site (Github Pages) :rocket:

This [GitHub action](https://github.com/features/actions) will handle the building and deploy process of your project to [GitHub Pages](https://pages.github.com/).

## Getting Started :airplane:

You can include the action in your workflow to trigger on any event that [GitHub actions supports](https://help.github.com/en/articles/events-that-trigger-workflows).

If the remote branch that you wish to deploy to doesn't already exist the action will create it for you.

Your workflow will also need to include the `actions/checkout` step before this workflow runs in order for the deployment to work.

You can view an example of this below.

```yml
name: Build and Deploy
on: [push]
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@master

    - name: Build and Deploy
      uses: Metal-Eagle/github-pages-deploy-action@master
      env:
        ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
        BRANCH: main #The remove branch to push to
        BUILD_DIR: dist # The folder, the action should deploy.
        BUILD_SCRIPT: npm install && npm run-script build # The build script the action should run prior to deploying.
```

If you'd like to make it so the workflow only triggers on push events to specific branches then you can modify the `on` section.

```yml
on:
  push:
    branches:
      - master
```

## Configuration

The `env` portion of the workflow **must** be configured before the action will work. 
You can add these in the `env` section found in the examples above. 

Any `secrets` must be referenced using the bracket syntax and stored in the GitHub repositories `Settings/Secrets` menu. 
You can learn more about setting environment variables with GitHub actions [here](https://help.github.com/en/articles/workflow-syntax-for-github-actions#jobsjob_idstepsenv).

Below you'll find a description of what each option does.

| Key            | Value Information                                            | Type      | Required |
| -------------- | ------------------------------------------------------------ | --------- | -------- |
| `ACCESS_TOKEN` | Depending on the repository permissions you may need to provide the action with a GitHub personal access token instead of the provided GitHub token in order to deploy. You can [learn more about how to generate one here](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line). **This should be stored as a secret**. | `secrets` | **No**   |
| `BRANCH`       | This is the branch you wish to deploy to, for example `gh-pages`,`docs` or `main`. | `env`     | **Yes**  |
| `FOLDER`       | The folder in your repository that you want to deploy. If your build script compiles into a directory named `build` you'd put it here. **Folder paths cannot have a leading `/` or `./`**. | `env`     | **Yes**  |
| `BUILD_SCRIPT` | If you require a build script to compile your code prior to pushing it you can add the script here. The Docker container which powers the action runs Node which means `npm` commands are valid. If you're using a static site generator such as Jekyll I'd suggest compiling the code prior to pushing it to your base branch. | `env`     | **No**   |

With the action correctly configured you should see the workflow trigger the deployment under the configured conditions.

## Contributing

We are a community effort, and everybody is most welcome to participate!

Be it filing bugs, formulating enhancements, creating pull requests, or any other means of contribution, we encourage contributions from everyone.

## Credits

- [ghpages](https://github.com/maxheld83/ghpages)
- [github-pages-deploy-action](https://github.com/grasilife/github-pages-deploy-action)
- [github-pages-deploy-action](https://github.com/testthedocs/github-pages-deploy-action)


