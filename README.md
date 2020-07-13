# ARENA Documentation Website

This is the ARENA Documentation website giving architecture, APIs, and step-by-step instructions to use the ARENA project. This is a static site generated by Jekyll, and is deployed on push to [https://conix-center.github.io/ARENA](https://conix-center.github.io/ARENA).

- TODO: Write the docs.
- TODO: Configure html-proofer correctly.

## Local Development
* [Install Jekyll](https://jekyllrb.com/docs/installation)
* Install any new ruby packages: `make install`
* Dependencies: `make update`
* Build and test: `make serve`
* Preview site at [http://localhost:4000](http://localhost:4000).

## Content

ARENA Documentation pages are written in markdown and placed in the `content` directory, except for `./index.md`.

Each `.md` file inside `content` must have [YAML Front Matter](https://jekyllrb.com/docs/front-matter) for navigation. The navigation details are determined by our theme. See the [just-the-docs](https://pmarsceill.github.io/just-the-docs/docs/navigation-structure) theme for more details about site navigation.

## Test 

```shell
make serve
```

This will create a watcher that will update and regenerate the localhost test site and allow you to immediately preview changes formatted to HTML.

The newly generated website will be placed in the `_site` directory.

## Check HTML and Links

Look for broken links and correct HTML using [html-proofer](https://github.com/gjtorikian/html-proofer):

```shell
make check
```

# ARENA-Related Repositories

- **ARENA-core**
  - https://github.com/conix-center/ARENA-core

- **ARENA-py python examples**
  - https://github.com/conix-center/ARENA-py

- **ATLAS**
  - https://github.com/conix-center/ATLAS

- **ARENA persist**
  - https://github.com/conix-center/arena-persist

- **Posefusion**
  - https://github.com/conix-center/posefusion

- **April Tag Decoding w. AR.js**
​  - https://github.com/conix-center/AR.js/blob/master/README.md#apriltag-detection 

