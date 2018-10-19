class StudentCommands < AttendanceBot

  command 'present' do |client, data, match|
    client.extend(ClientMethods)
    checkedTime = GoogleSheet.post_to_sheet(client.user(data), client.real_name(data), client.local_time(data))
    if checkedTime
      client.say(text: "Awesome, you signed in at #{time}", channel: data.channel)
    else
      client.say(text: "Oh noo, I couldn't sign you in! Please check in with one of your instructors.", channel: data.channel)
    end
  end


  command 'standing' do |client, data, match|
    client.extend(ClientMethods)

    absences = GoogleSheet.absences(client.user(data), client.real_name(data))
    client.say(text: "You've been absent #{absences} time(s) in #{user.mod}.", channel: data.channel)
  end


  command 'my latenesses' do |c, data, match|
    c.extend(ClientMethods)

    latenesses = GoogleSheet.latenesses(c.user(data), c.real_name(data))
    client.say(text: "You've been late #{latenesses} time(s) in #{user.mod}.", channel: data.channel)
  end


end
