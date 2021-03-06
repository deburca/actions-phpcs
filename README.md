# actions-phpcs
PHPCS action for GitHub on PHP 7.4

## Setup
Add these lines to your YAML config file
```yaml
- name: PHP Code Style (phpcs)
  uses: chindit/actions-phpcs@master
```

**WARNING** : Be sure you have this line **before** :
```yaml
- uses: actions/checkout@v2
```

Your workflow file should look like this:
```yaml
name: phpcs
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: PHP Code Style (phpcs)
        uses: chindit/actions-phpcs@master
        with:
          # Folder to check code style
          dir: src/
```

**TIP**: You can replace `@master` by `@1.0.0` or any specific version of this
package you'd like to use.

### Rules
By default, `phpcs` will look for a `phpcs.xml.dist` file at the root of your project.

So, make sure this file exists and has all the rules you want to apply.

### Arguments
By default, `phpcs` is ran without any argument.

If you want, you can specify scan directory on anything else on your `phpcs.xml.dist`

You can also specify scan directory by adding
```yaml	
  with:	
    dir: './src' 
