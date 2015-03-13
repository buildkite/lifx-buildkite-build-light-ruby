# LIFX Buildkite Build Light (Ruby)

An example [Buildkite](https://buildkite.com/) webhook endpoint for creating a [LIFX](https://lifx.com/) powered build light.

![LIFX panda build light in action](http://i.imgur.com/FrBTgnf.gif)

## Usage

1. Firstly, deploy it to Heroku: [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

2. Find the secret. In your new Heroku app go to Settings → Config Variables → Reveal Config Variables, and copy the `secret` variable value.

3. Set up the webhook. In Buildkite go to Settings → Notifications → Webhooks and add a new webhook for your Heroku app's URL, adding `?secret=your-secret` to the end. For example: `https://your-app-name.herokuapp.com/?secret=your-secret`

4. Trigger a build!

## Customising

Check out [api.lifx.com](https://api.lifx.com/) to see what’s possible with the API. The possibilities are endless!

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
