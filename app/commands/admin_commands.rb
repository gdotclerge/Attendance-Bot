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


  command 'admin attendance' do |client, data, match|
    client.extend(ClientMethods)
    attendance = GoogleSheet.attendance(client.user(data))
    if attendance["missing"].length > 0
      @slack_client ||= ::Slack::Web::Client.new
      attendance["missing"].each do |student|
        su = client.find_slack_user(student)
        if su
          im_channel = @slack_client.im_open(user: su.id)['channel']['id']
          client.say(text: "Hi :wave:\n Your instructors are checking attendance now and you haven't checked in yet!", channel: im_channel)
        else
          client.say(text: "Oh no, I can't seem to find #{student}, please check to see if their slack name is the same as their name on the attendance sheet.", channel: data.channel)
        end
      end
      client.say(text: "#{attendance["missing"].join(", ")} did not check in, I've sent a direct message as a reminder.", channel: data.channel)
    end
    header = "*Student*   |  Time\n--------------------"
    client.say(text: " #{header}\n #{attendance["all_students"].join("\n")}", channel: data.channel)
  end


end
