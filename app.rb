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
    Faraday.new(url: 'https://api.lifx.com') do |conn|
      conn.authorization :Bearer, settings.lifx_access_token
    end
  end
  def breathe_path
    "/v1beta1/lights/#{settings.bulb_selector}/effects/breathe.json"
  end
end

before do
  halt 401 if params[:secret] != settings.secret
end

post "/" do
  event = JSON.parse(request.body)

  if request.headers["X-Buildkite-Event"] == "build"
    case event['build']['state']
    when 'running'
      lifx_api.post breathe_path, power_on:   false,
                                  color:      "yellow brightness:5%",
                                  from_color: "yellow brightness:35%",
                                  period:     5,
                                  cycles:     9999,
                                  persist:    true
    when 'passed'
      lifx_api.post breathe_path, power_on:   false,
                                  color:      "green brightness:75%",
                                  from_color: "green brightness:10%",
                                  period:     0.45,
                                  cycles:     3,
                                  persist:    true,
                                  peak:       0.2
    when 'failed'
      lifx_api.post breathe_path, power_on:   false,
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
