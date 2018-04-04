# AWS Video Center Blueprint

Site supporting Video on Demand and Live Streams from AWS.

## UI Styles

To update styles you need to run the following command and then change the corresponding `.scss` file, which requires [Sass](https://sass-lang.com/install) to be installed.

**Examples:**

```
sass sources/scss/theme.scss static-assets/css/theme-min.css -s compressed
sass sources/css/responsive.css static-assets/css/responsive-min.css -s compressed
```

## UI Scripts

To update edit JavaScript files, make all changes to the source `.js` files. To minify for delivery, use a tool such as minifier.org.

**Example:**

```
curl -X POST -s --data-urlencode 'source@sources/js/app.js' --data-urlencode 'type=js' https://minify.minifier.org | python -c "import json,sys;print(json.load(sys.stdin)['minified'])" > static-assets/js/app-min.js
```
