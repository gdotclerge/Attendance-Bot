require 'spec_helper'

describe SlackTimelyBot::Commands::Admin::Test do
  # client = SlackRubyBot::Client.new
  # client.store = { users: {user: {real_name: "Test Bot"}}}

  def bot
    SlackTimelyBot::Bot.instance
  end

  class FakeStore
    def initialize(users)
      @users = users
    end
  end
  #
  # # client needs to be:
  # need to creata  new client
  # # clientinst.store = FakeStore.new({"#{client.name}": {real_name: "Ruby Bot", is_admin: true}})
  #

  subject { bot }

  # let(:client) {
  #   client = SlackRubyBot::Client.new
  #   client.store = FakeStore.new({"#{client.name}": {real_name: "Ruby Bot", is_admin: true}})
  #   client
  # }



  # before(:all) do
  #   # binding.pry
  # end

  # let(:client) { app.send(:client) }

  it 'returns "Admin tests are running"' do
    # binding.pry
    expect(message: "#{SlackRubyBot.config.user} admin test", channel: 'channel').to respond_with_slack_message("Admin tests running.")
  end
end
