class AdminCommands < AttendanceBot

  command 'admin test' do |client, data, match|
    client.say(text: "Admin// Currently Deployed and working", channel: data.channel)
  end


  command 'admin set mod' do |client, data, match|
    client.extend(ClientMethods)
    mod = "Mod" + match["expression"]
    client.slack_members(data).each do |slack_id|
      user = User.find_by(slack_id: slack_id)
      user.update_attributes(mod: mod)
    end

    # check if spreadsheet is set
    # check if tab exists on set spreadsheet (is valid mod number?)
    client.say(text: "Updated #{c.slack_members(data).count} users to #{mod}.", channel: data.channel)
  end


  command 'admin init' do |client, data, match|
    client.extend(ClientMethods)
    sheet = GoogleSheet.valid_spreadsheet(client.spreadsheet_key(match))

    binding.pry
    client.slack_members(data).each do |slack_id|
      User.create(slack_id: slack_id, sheet_key: client.spreadsheet_key(match), mod: "Mod1")
    end

    # need to check if spreadsheet exists example Spreadsheet.exists?(sheet_key)
    client.say(text: "#{slack_members.count} were initialized.", channel: data.channel)
  end


command 'admin check attendance' do |c, data, match|
  c.extend(ClientMethods)

  attendance = GoogleSheet.check_attendance(c.user(data))

  client.say(text: "#{attendance}", channel: data.channel)
end


command 'admin attendance' do |client, data, match|
  client.extend(ClientMethods)

  @slack_client ||= ::Slack::Web::Client.new
  im_channel = @slack_client.im_open(user: data.user)['channel']['id']
  students = GoogleSheet.attendance(client.user(data))
  students_str = students.select { |student| student != nil }.join(", ")
  if students_str.length > 0
    client.say(text: "#{students_str} did not check in, I've sent them a DM reminder", channel: im_channel)
  else
    client.say(text: "Nice! Everyone checked in!", channel: im_channel)
  end
end


end
