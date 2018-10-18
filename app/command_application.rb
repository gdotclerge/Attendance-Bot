class ImHereBot < SlackRubyBot::Bot


  command 'admin test' do |client, data, match|
    client.say(text: "Currently Deployed and working", channel: data.channel)
  end


  # ========== ADMIN COMMANDS ===============


  command 'admin set mod' do |c, data, match|
    c.extend(ClientMethods)

    mod = "Mod" + match["expression"]

    c.slack_members(data).each do |slack_id|
      user = User.find_by(slack_id: slack_id)
      user.update_attributes(mod: mod)
    end

    # check if spreadsheet is set
    # check if tab exists on set spreadsheet (is valid mod number?)
    client.say(text: "Updated #{c.slack_members(data).count} users to #{mod}.", channel: data.channel)
  end


  command 'admin init' do |c, data, match|
    c.extend(ClientMethods)

    c.slack_members(data).each do |slack_id|
      User.create(slack_id: slack_id, sheet_key: c.spreadsheet_key(match))
    end

    # check if spreadsheet exists
    # Spreadsheet.exists?(sheet_key)
    client.say(text: "#{slack_members.count} were initialized.", channel: data.channel)
  end


  command 'admin check attendance' do |c, data, match|
    c.extend(ClientMethods)

    attendance = GoogleSheet.check_attendance(c.user(data))

    client.say(text: "#{attendance}", channel: data.channel)
  end


  command 'admin attendance' do |c, data, match|
    c.extend(ClientMethods)

    @slack_client ||= ::Slack::Web::Client.new
    im_channel = @slack_client.im_open(user: data.user)['channel']['id']
    students = GoogleSheet.attendance(c.user(data))
    students_str = students.select { |student| student != nil }.join(", ")

    # client.store.users.find do |k, v|
    #   binding.pry
    #   v.real_name == "Garry Clerge"
    # end

    client.say(text: "#{students.select { |student| student != nil }.join(", ")}", channel: im_channel)
  end


  # ========== STUDENT COMMANDS ===============


  command 'present' do |c, data, match|
    c.extend(ClientMethods)

    checkedTime = GoogleSheet.post_to_sheet(c.user(data), c.real_name(data), c.current_time(data))

    # Need to figure out Error handling. Should have something liket the below on every method. Can abstract out
    # Maybe send necessary info into method that handles responding
    checkedTime ? c.say(text: "Awesome, you signed in at #{time}", channel: data.channel) : c.say(text: "We couldn't sign you in", channel: data.channel)
  end


  command 'my absences' do |c, data, match|
    c.extend(ClientMethods)

    absences = GoogleSheet.absences(c.user(data), c.real_name(data))
    client.say(text: "You've been absent #{absences} time(s) in #{user.mod}.", channel: data.channel)
  end


  command 'my latenesses' do |c, data, match|
    c.extend(ClientMethods)

    latenesses = GoogleSheet.latenesses(c.user(data), c.real_name(data))
    client.say(text: "You've been late #{latenesses} time(s) in #{user.mod}.", channel: data.channel)
  end


end
