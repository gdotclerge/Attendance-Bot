require_relative 'spreadsheet.rb'
require 'slack-ruby-bot'
# require_relative 'command_application.rb'
require 'pry'


class ImHereBot < SlackRubyBot::Bot


  command 'ping' do |client, data, match|
    # binding.pry
    client.say(text: "awesome", channel: data.channel)
  end

  command 'present' do |client, data, match|
    # binding.pry
    put_cells(client.store.users[data.user]['real_name'])
  end

  operator 'new class' do |client, data, match|
    binding.pry
  end

end

ImHereBot.run
