require_relative '../config/environment'

binding.pry

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end





ImHereBot.run
