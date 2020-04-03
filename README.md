# AWS Video Center Blueprint

Site supporting Video on Demand and Live Streams from AWS.

## UI Styles

To update styles you, all changes should be made to the source `.scss` or `.css` file. After edits are complete, the following command(s) should be run, which requires [Sass](https://sass-lang.com/install) to be installed.

**Examples:**

```
sass sources/scss/theme.scss static-assets/css/theme-min.css -s compressed
sass sources/css/responsive.css static-assets/css/responsive-min.css -s compressed
```

## UI Scripts

To update JavaScript files, make all changes to the source `.js` files. To minify for delivery, use a tool such as minifier.org.

**Example:**

```
curl -X POST -s --data-urlencode 'source@sources/js/app.js' --data-urlencode 'type=js' https://minify.minifier.org | python -c "import json,sys;print(json.load(sys.stdin)['minified'])" > static-assets/js/app-min.js
```

## Security configuration

Run this commands to prevent development files from reaching repo

```
git update-index --assume-unchanged config/studio/aws/aws.xml
git update-index --assume-unchanged config/studio/aws/elastic-transcoder/default-profile.xml
git update-index --assume-unchanged config/engine/site-config.xml
```