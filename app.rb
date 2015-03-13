require 'sinatra'
require 'json'
require 'faraday'

set :lifx_access_token, ENV['LIFX_ACCESS_TOKEN'] || raise("no LIFX_ACCESS_TOKEN set")
set :bulb_selector,     ENV['BULB_SELECTOR']     || raise("no BULB_SELECTOR set")
set :project_name,      ENV['PROJECT_NAME']      || raise("no PROJECT_NAME set")
set :branch_name,       ENV['BRANCH_NAME']       || raise("no BRANCH_NAME set")
set :secret,            ENV['SECRET']            || raise("no SECRET set")

helpers do
  def lifx_api
    Faraday.new(url: "https://api.lifx.com") do |c|
      c.authorization :Bearer, settings.lifx_access_token
      c.use Faraday::Response::RaiseError
    end
  end
end

post "/" do
  halt(401, 'Looks like you forgot to add ?secret=the-secret') if params[:secret].nil?
  halt(401, 'Secret is incorrect') if params[:secret] != settings.secret

  event = JSON.parse(request.body.read)

  if request["X-Buildkite-Event"] == "build"
    case event['build']['state']
    when 'running'
      lifx_api.post "/lights/#{settings.bulb_selector}/effects/breathe.json",
        power_on:   false,
        color:      "yellow brightness:5%",
        from_color: "yellow brightness:35%",
        period:     5,
        cycles:     9999,
        persist:    true
    when 'passed'
      lifx_api.post "/lights/#{settings.bulb_selector}/effects/breathe.json",
        power_on:   false,
        color:      "green brightness:75%",
        from_color: "green brightness:10%",
        period:     0.45,
        cycles:     3,
        persist:    true,
        peak:       0.2
    when 'failed'
      lifx_api.post "/lights/#{settings.bulb_selector}/effects/breathe.json",
        power_on:   false,
        color:      "red brightness:60%",
        from_color: "red brightness:25%",
        period:     0.1,
        cycles:     20,
        persist:    true,
        peak:       0.2
    end
  end

  status 200
end

get "/" do
  "<div style=\"font:24px Avenir,Helvetica;max-width:32em;margin:2em;line-height:1.3\"><h1 style=\"font-size:1.5em\">Huzzah! You’re almost there.</h1><p style=\"color:#666\">Now create a webhook in your <a href=\"https://buildkite.com/\" style=\"color:black\">Buildkite</a> notification settings with this URL, substituting the secret from your Heroku app’s config&nbsp;variables:</p><p>#{request.scheme}://#{request.host}/?secret=the-secret</p></div>"
end
