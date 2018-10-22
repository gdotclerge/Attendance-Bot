$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'slack-timelybot'
require 'web'
require 'require_all'
require_all 'lib'


Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

Thread.abort_on_exception = true

Thread.new do
  begin
    SlackTimelyBot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run SlackTimelyBot::Web
