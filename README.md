# timber-grunt

Timber is an amazing theme framework from Shopify. This repo is more of an introduction or guideline to get it set up with Grunt.

## What is Timber?

Timber is a theme framework for Shopify that helps you get your store up and running quickly. It provides all required theme templates, a starter set of liquid tags, and some basic styles and modules for you to extend on.

Styling and customization is left up to you. Some base styles and helpers are included, but there is **no need to remove any code before you start**. Simply download and get designing.

Visit the [Timber's Documentation](http://shopify.com/timber) page to find out more about the templates, liquid tags, CSS framework, and JavaScript modules included.

Timber's documentation is hosted on [GitHub Pages](http://pages.github.com/). View the raw files in the [gh-pages branch](https://github.com/Shopify/Timber/tree/gh-pages). Please report any discrepancies, bugs, or requests in [issues](https://github.com/Shopify/Timber/issues).

## What is Grunt?

[Grunt](http://gruntjs.com/) is a task runner that can make certain tasks that developers need to do on a daily basis a lot easier. Why use a task runner? In one word: automation. The less work you have to do when performing repetitive tasks like minification, compilation, unit testing, linting, etc, the easier your job becomes. After you've configured it, a task runner can do most of that mundane work for you—and your team—with basically zero effort.

## What does timber-grunt do?

This is a simple implementation of what Grunt can do. Out of the box, timber-grunt concatenates your Sass and compresses your images. One of its most time saving features is that it auto-uploads files directly to your shop on save. No more copy/pasting or doing all of your edits directly in Shopify's template editor. Because we're using Grunt, there are many other possibilities. For example, you could harness the power of Coffeescript by creating a `/scripts` folder and using the **grunt-contrib-coffee** plugin to compile to the `/assets` folder.

## Getting Started

The first thing you'll want to do is clone this repo:

    git clone https://github.com/graygilmore/timber-grunt.git

If you haven't used Grunt before, you'll need to install the Grunt CLI first:

    npm install -g grunt-cli

If you've already used Grunt, simply `cd` into your project's directory and type `npm install`. This will install all of the packages that are listed in the project's `package.json` file. This will create a new folder called `node_modules` where all of the Grunt plugins live. You'll want to make sure that folder is being ignored in your `.gitignore` file.

### Talking to Shopify

One of the *best* parts of working with Grunt is how quickly you'll be able to see your work appear on the live shop from your local machine. We're using the [grunt-shopify](https://github.com/wilr/grunt-shopify) plugin to help us talk to our shop.

The first thing you'll need to do is log into your shop and create a new private app: https://your-shop.myshopify.com/admin/apps/private/new. The title doesn't matter, I usually just name mine "Grunt".

Once you've created your new private app, click on it and you'll see a bunch of information about it. Specifically, we need the **API Key** and **Password**. In the root of your project, create a new file called `shopify.json` and fill it out like this:

    {
      "private_api": "API_KEY",
      "private_password": "PASSWORD",
      "shop_url": "YOUR-SHOP.myshopify.com",
      "theme_id": ""
    }

Replace the text in ALL CAPS with your own data. You'll notice that the `theme_id` field is blank, we'll get to that in a bit.

Okay! Now we can talk to our shop! To test this out, type `grunt shopify:themes` into terminal. If everything went well, you should see a list of all of the themes currently installed on your shop. Neat, right?

### Uploading the Theme

The first thing you'll want to do before digging into making changes will be to upload the theme to your shop. Run `grunt package` to create a .zip of the theme and upload it to your shop: https://your-shop.myshopify.com/admin/themes

Once it's uploaded, run `grunt shopify:themes`. You should now see your new theme listed. It might look something like this:

    $ grunt shopify:themes
    10766735 - timber-grunt-v0-0-1 (main)

The number in the beginning is the theme's ID. You'll need to enter that value into the `theme_id` parameter in the shopify.json file.

### Updating Files

All done! The only thing left to do is to run `grunt` in the terminal and Grunt will take it from there. Grunt will watch your files for changes and upload them accordingly.
