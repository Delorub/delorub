# Frontend
## Technology stack
 * `Npm` and `Yarn`
 * `Webpack` We use webpack bundler to handle all ourcode and assets
 * `React + redux` parts of application are written on react + redux
 * `Webpack-dev-server` For client-side development and markup development we use webpack dev server
 * `React-on-Rails`
 * `Sprockets` over `Webpack` to bring assets to Rails application
 * `SASS` for stylesheets
 * `Bootstrap 3` as main css framework
 * And many others!

## Project structure
 * `client/`
    *  `app/` All frontend application
        * `bundles/` React bundles
        * `javascripts/` Client-side javascripts
        * `stylesheets/` Client-side styles
        * `images/` Client-side images which are used from css's, js's
        * `*other folders*` You can add as many folders as you want, such as `fonts`, but you can use files only from application code
    *  `markup/` Folder where you can develop markup templates
    *  `bootstrap.yml` Some bootstrap
 * `public/` Folder which store static assets, such as favicons, static images, robots.txt, etc, which are used only from html, but not from css or js

## Installation
```sh
$ cd client
$ npm install
```

## Development process
### Starter pack
For client-side development please use webpack-dev-server. It starts by simple cmd:
```sh
yarn start
```
After that, you can see your markup files from `/client/markup/` folder on `localhost:9000`. Also, all static asset files from `/public/` are also reachable from `localhost:9000`.
### Dependencies
Please add dependencies to npm `package.json` and include them from your js/sass files
### Markup development
1. Create new markup file in `client/markup` folder.
2. Link stylesheets from `/website-bundle.css`
3. Link scripts from `/website-bundle.js`
4. Store your static files in `/public/` and link them by absolute path. For example, you have `/public/images/logo.png`, and you can insert img by `<img src="/images/logo.png">`
5. Store files for css in `/client/app/`, and link them by relative path's
6. Write your html's
7. ...
8. Profit!
