require 'spec_helper'

describe SlackTimelyBot::Commands::Student::Present do
  def app
    SlackTimelyBot::Bot.instance
  end

  subject { app }

  it "responds with a confirmation that you're checked in and the time you checked in." do
    expect(message: "#{SlackRubyBot.config.user} present", channel: 'channel').to respond_with_slack_message("Awesome, you signed in at.")
  end
end
