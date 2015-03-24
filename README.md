# LIFX Buildkite Build Light (Ruby)

An example Ruby [Buildkite](https://buildkite.com/) webhook endpoint for creating a [LIFX](https://lifx.com/) powered build light.

:v::panda_face::v:

![LIFX panda build light in action](http://i.imgur.com/FrBTgnf.gif)

## Usage

1. **Deploy it to Heroku** <br>[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

2. **Find the secret:** In your new Heroku app go to Settings → Config Variables → Reveal Config Variables, and copy the `WEBHOOK_TOKEN` variable value.

3. **Set up the webhook:** In Buildkite go to Settings → Notifications → Webhooks and add a new webhook pointing to your new Heroku app, and using the token you copied from your Heroku app’s config.

4. **Trigger a build!** :tada:

## Personalising

One bulb per project? One bulb per build pipeline step? A LIFX chandelier that twinkles rainbows after each deploy? The possibilities are endless!

Check out [api.lifx.com](https://api.lifx.com/) to see what’s possible with the API, then fork this project, and get hacking.

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
