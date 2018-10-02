# require_relative 'spreadsheet.rb'
# require 'slack-ruby-bot'
# require_relative 'command_application.rb'
# require 'pry'


class ImHereBot < SlackRubyBot::Bot



  # ========== ADMIN COMMANDS ===============

  command 'admin set mod' do |client, data, match|
    mod = "Mod"+match["expression"]
    # check if spreadsheet is set
    # check if tab exists on set spreadsheet (is valid mod number?)

    slack_members = ImHereBot.get_slack_members(client, data)
    # Need to make helper class so we can call Helper.get_slack_members...

    slack_members.each do |slack_id|
      user = User.find_by(slack_id: slack_id)
      user.mod = mod
    end

    client.say(text: "Updated #{slack_members.count} users to #{mod}.", channel: data.channel)
  end

  command 'admin init' do |client, data, match|
    sheet_key = ImHereBot.spreadsheet_key(match)
    # check if spreadsheet exists
    # Spreadsheet.exists?(sheet_key)
    slack_members = client.store.channels[data.channel].members

    slack_members.each do |slack_id|

      User.create(slack_id: slack_id, sheet_key: sheet_key)
    end

    client.say(text: "#{slack_members.count} were initialized.", channel: data.channel)
  end

  # ========== STUDENT COMMANDS ===============


  # command 'ping' do |client, data, match|
  #   client.say(text: "awesome", channel: data.channel)
  # end

  command 'present' do |client, data, match|
    slack_id = data.user
    real_name = ImHereBot.real_name(client, data)
    user = User.find_by(slack_id: slack_id)
    time = GoogleSheet.post_to_sheet(user, real_name)

    binding.pry
    client.say(text: "Awesome, you signed in at #{time}", channel: data.channel)


    # str_arr = match["expression"].split("/")
    # index = str_arr.index("d") + 1
    # sheet_code = str_arr[index]
    # put_cells(client.store.users[data.user]['real_name'])
    # McColemanTesterBot.is_admin(client)
  end

  operator "new class" do |client, data, match|
    binding.pry
  end

  private

  # ========== HELPER FUNCTIONS ===============

  def self.spreadsheet_key(match)
    str_arr = match["expression"].split("/")
    index = str_arr.index("d") + 1
    str_arr[index]
  end

  def self.permitted?(client, data, match)
    admin_status = client.store.users[data.user].is_admin
    ImHereBot.admin_command?(match) ? admin_status : true
  end

  def self.user(client, data)
    client.store.users[data.user]
  end

  def self.real_name(client, data)
    self.user(client, data).real_name
  end

  def self.admin_command?(match)
    match['command'].split(" ")[0] === "admin"
  end

  def self.get_slack_members(client, data)
    client.store.channels[data.channel].members
  end

end
