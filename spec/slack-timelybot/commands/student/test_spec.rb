require 'spec_helper'

describe SlackTimelyBot::Commands::Student::Test do

  def app
    SlackTimelyBot::Bot.instance
  end

  # client = SlackRubyBot::Client.new
  # client.store = { users: {user: {real_name: "Test Bot"}}}

  subject { app }

  # let(:client) {
  #   client = SlackRubyBot::Client.new
  #   client.store = { users: {user: {real_name: "Test Bot"}}}
  #
  #   app.send(:client)
  #  }


  it 'returns "Student tests are running"' do
    expect(message: "#{SlackRubyBot.config.user} test", channel: 'channel').to respond_with_slack_message("Student tests running")
  end
end
