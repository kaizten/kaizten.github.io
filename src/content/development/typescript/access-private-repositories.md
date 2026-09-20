# TypeScript. Access to private repositories

- [TypeScript. Access to private repositories](#typescript-access-to-private-repositories)
    - [1. Locate or create an `.npmrc` file](#1-locate-or-create-an-npmrc-file)
    - [2. Add the private repository URL](#2-add-the-private-repository-url)
    - [3. Verify the configuration](#3-verify-the-configuration)
    - [4. Use the private GitHub token](#4-use-the-private-github-token)

The following method illustrate how to use private GitHub packages in a TypeScript project.

### 1. Locate or create an `.npmrc` file

The `.npmrc` file is used to configure npm and Yarn settings. You can use either a project-specific `.npmrc` file in the root directory of your project or a global `.npmrc` file located in your home directory (`~/.npmrc`).

### 2. Add the private repository URL

Include the private repository URL and a GitHub authentication token in the `.npmrc` file, as can be seen as follows:

```plaintext
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
@kaizten:registry=https://npm.pkg.github.com
```
It should be noted that `GITHUB_TOKEN` must be the token generated from GitHub.

### 3. Verify the configuration

Run the following command to ensure [yarn](https://yarnpkg.com) recognizes the private repository:

```bash
yarn config list
```

The output must be similar to this:
```bash
yarn config v1.22.22
warning package.json: No license field
info yarn config
{
  'version-tag-prefix': 'v',
  'version-git-tag': true,
  'version-commit-hooks': true,
  'version-git-sign': false,
  'version-git-message': 'v%s',
  'init-version': '1.0.0',
  'init-license': 'MIT',
  'save-prefix': '^',
  'bin-links': true,
  'ignore-scripts': false,
  'ignore-optional': false,
  registry: 'https://registry.yarnpkg.com',
  'strict-ssl': true,
  'user-agent': 'yarn/1.22.22 npm/? node/v20.14.0 linux x64',
  lastUpdateCheck: 1734513615970
}
info npm config
{
  '//npm.pkg.github.com/:_authToken': '<GITHUB_TOKEN>',
  '@kaizten:registry': 'https://npm.pkg.github.com'
}
Done in 0.04s.
```
Check if the registry and token configurations are correctly listed. In this case, `<GITHUB_TOKEN>` must be the GitHub token configured.

### 4. Use the private GitHub token

Once the configuration has been properly set, private dependencies from GitHub can be used. In the following, a private library is add to the current projec:
```
export GITHUB_TOKEN=<GITHUB_TOKEN>
yarn add @kaizten/kaizten-typescript
```
Replace `@kaizten/kaizten-typescript`-package with the name of any other package hosted on the GitHub private repository. In this case, `<GITHUB_TOKEN>` must be the GitHub token configured.