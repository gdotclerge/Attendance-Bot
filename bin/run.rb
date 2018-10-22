require_relative '../config/environment'

Dotenv.load('config/.env')

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

ImHereBot.run
# write a begin rescue here
