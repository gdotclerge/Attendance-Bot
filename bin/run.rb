require_relative '../config/environment'

Dotenv.load('config/slack_credentials.env')

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end


ImHereBot.run
