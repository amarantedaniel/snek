# Snek
[![CircleCI](https://circleci.com/gh/amarantedaniel/snek.svg?style=svg)](https://circleci.com/gh/amarantedaniel/snek)

A snake clone in elm

<img src="https://raw.githubusercontent.com/amarantedaniel/snek/master/snek.jpg">

## Available scripts

In the project directory you can run:

### `elm-app build`

Builds the app for production to the `build` folder.

The build is minified, and the filenames include the hashes.
Your app is ready to be deployed!

### `elm-app start`

Runs the app in the development mode.
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.
You will also see any lint errors in the console.

You may change the listening port number by using the `PORT` environment variable. For example type `PORT=8000 elm-app start ` into the terminal/bash to run it from: [http://localhost:8000/](http://localhost:8000/).

### `elm-app install`

Alias for [`elm install`](http://guide.elm-lang.org/get_started.html#elm-install)

Use it for installing Elm packages from [package.elm-lang.org](http://package.elm-lang.org/)

### `elm-app test`

Run tests with [node-test-runner](https://github.com/rtfeldman/node-test-runner/tree/master)

You can make test runner watch project files by running:

```sh
elm-app test --watch
```

## Deployment

`elm-app build` creates a `build` directory with a production build of your app. Set up your favourite HTTP server so that a visitor to your site is served `index.html`, and requests to static paths like `/static/js/main.<hash>.js` are served with the contents of the `/static/js/main.<hash>.js` file.

### Building for Relative Paths

By default, Create Elm App produces a build assuming your app is hosted at the server root.

To override this, specify the `homepage` in your `elmapp.config.js`, for example:

```js
module.exports = {
    homepage: "http://mywebsite.com/relativepath"
}
```

This will let Create Elm App correctly infer the root path to use in the generated HTML file.

### GitHub Pages

#### Step 1: Add `homepage` to `elmapp.config.js`

**The step below is important!**

**If you skip it, your app will not deploy correctly.**

Open your `elmapp.config.js` and add a `homepage` field:

```js
module.exports = {
    homepage: "https://myusername.github.io/my-app",
}
```

Create Elm App uses the `homepage` field to determine the root URL in the built HTML file.

#### Step 2: Build the static site

```sh
elm-app build
```

#### Step 3: Deploy the site by running `gh-pages -d build`

We will use [gh-pages](https://www.npmjs.com/package/gh-pages) to upload the files from the `build` directory to GitHub. If you haven't already installed it, do so now (`npm install -g gh-pages`)

Now run:

```sh
gh-pages -d build
```

#### Step 4: Ensure your project’s settings use `gh-pages`

Finally, make sure **GitHub Pages** option in your GitHub project settings is set to use the `gh-pages` branch:

![GH Pages branch](https://i.imgur.com/HUjEr9l.png)

#### Step 5: Optionally, configure the domain

You can configure a custom domain with GitHub Pages by adding a `CNAME` file to the `public/` folder.
