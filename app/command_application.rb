class ImHereBot < SlackRubyBot::Bot


  command 'admin test' do |client, data, match|
    client.say(text: "Currently Deployed and working", channel: data.channel)
  end


  # ========== ADMIN COMMANDS ===============

  command 'admin set mod' do |client, data, match|
    mod = "Mod"+match["expression"]
    # check if spreadsheet is set
    # check if tab exists on set spreadsheet (is valid mod number?)

    slack_members = ImHereBot.get_slack_members(client, data)
    # Need to make helper class so we can call Helper.get_slack_members...
    slack_members.each do |slack_id|
      user = User.find_by(slack_id: slack_id)
      # user.mod = mod
      # user.save
      user.update_attributes(mod: mod)
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

  command 'admin check attendance' do |client, data, match|
    user = User.find_by(slack_id: data.user)
    attendance = GoogleSheet.check_attendance(user)
    client.say(text: "#{attendance}", channel: data.channel)
  end

  command 'admin attendance' do |client, data, match|
    user = User.find_by(slack_id: data.user)
    @slack_client ||= ::Slack::Web::Client.new
    im_channel = @slack_client.im_open(user: data.user)['channel']['id']
    students = GoogleSheet.attendance(user)
    students_str = students.select { |student| student != nil }.join(", ")

    # client.store.users.find do |k, v|
    #   binding.pry
    #   v.real_name == "Garry Clerge"
    # end

    client.say(text: "#{students.select { |student| student != nil }.join(", ")}", channel: im_channel)
    binding.pry

  end



  # ========== STUDENT COMMANDS ===============

  command 'present' do |client, data, match|
    slack_id = data.user
    real_name = ImHereBot.real_name(client, data)
    user = User.find_by(slack_id: slack_id)
    time = GoogleSheet.post_to_sheet(user, real_name)
    client.say(text: "Awesome, you signed in at #{time}", channel: data.channel)
  end

  command 'my absences' do |client, data, match|
    user = User.find_by(slack_id: data.user)
    real_name = ImHereBot.real_name(client, data)
    absences = GoogleSheet.absences(user, real_name)
    client.say(text: "You've been absent #{absences} time(s) in #{user.mod}.", channel: data.channel)
  end

  command 'my latenesses' do |client, data, match|
    user = User.find_by(slack_id: data.user)
    real_name = ImHereBot.real_name(client, data)
    latenesses = GoogleSheet.latenesses(user, real_name)
    client.say(text: "You've been late #{latenesses} time(s) in #{user.mod}.", channel: data.channel)
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
    ImHereBot.admin_command?(match) ? admin_status : !admin_status
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
