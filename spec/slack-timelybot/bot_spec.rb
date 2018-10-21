require 'spec_helper'
require 'pry'

describe SlackTimelyBot::Bot do
  def app
    SlackTimelyBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end
