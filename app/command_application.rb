require_relative 'spreadsheet.rb'
require 'slack-ruby-bot'
# require_relative 'command_application.rb'
require 'pry'


class ImHereBot < SlackRubyBot::Bot

  @@session = GoogleSheet.from_service_account_key("config/config.json")



  command 'admin present' do |client, data, match|
    client.say(text: "awesome", channel: data.channel)
  end

  command 'admin init' do |client, data, match|
    sheet_key = ImHereBot.spreadsheet_key(match)
    slack_members = client.store.channels[data.channel].members
  end

  def self.spreadsheet_key(match)
    str_arr = match["expression"].split("/")
    index = str_arr.index("d") + 1
    str_arr[index]
  end



  command 'ping' do |client, data, match|
    binding.pry
    client.say(text: "awesome", channel: data.channel)
  end

  command 'present' do |client, data, match|
    # str_arr = match["expression"].split("/")
    # index = str_arr.index("d") + 1
    # sheet_code = str_arr[index]


    # put_cells(client.store.users[data.user]['real_name'])
    # McColemanTesterBot.is_admin(client)

  end

  operator "new class" do |client, data, match|
    binding.pry
  end


  def self.permitted?(client, data, match)
    admin_status = client.store.users[data.user].is_admin
    ImHereBot.admin_command?(match) ? admin_status : true
  end

  def self.admin_command?(match)
    match['command'].split(" ")[0] === "admin"
  end

end
