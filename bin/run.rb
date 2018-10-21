require_relative '../config/environment'

Dotenv.load('config/.env')

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

Thread.new do
  begin
    SlackTimelyBot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end
