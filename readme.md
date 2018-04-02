# AWS Video Center Blueprint

Site supporting Video on Demand and Live Streams from AWS.

## UI Setup

To update styles you need to run the following command and then change the corresponding `.scss` file, which requires [Sass](https://sass-lang.com/install) to be installed.

**Example:**

```
sass sources/scss/theme.scss static-assets/css/theme-min.css -s compressed
sass sources/css/responsive.css static-assets/css/responsive-min.css -s compressed
```
