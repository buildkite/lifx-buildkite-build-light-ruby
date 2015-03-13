# LIFX Buildkite Build Light (Ruby)

An example [Buildkite](https://buildkite.com/) webhook endpoint for creating a [LIFX](https://lifx.com/) powered build light.

![LIFX panda build light in action](http://i.imgur.com/FrBTgnf.gif)

## Usage

Firstly, deploy it to Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Then add your new app’s URL as a webhook in your Buildkite account (Settings → Notifications → Webhooks).

Don't forget to add your secret to the end of URL to ensure no-one else can control your build light, for example: `https://your-app-name.herokuapp.com/?secret=your-secret`

## Customising

Check out [api.lifx.com](https://api.lifx.com/) to see what’s possible with the API. The possibilities are endless!

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
