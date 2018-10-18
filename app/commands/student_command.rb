class StudentCommands < AttendanceBot

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
