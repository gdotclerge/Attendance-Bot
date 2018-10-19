# require_relative '../mixins/subscribe.rb'

class StudentCommands < AttendanceBot
  include Mixins::Subscribe

  subscribe_command 'present' do |client, data, match|
    checkedTime = GoogleSheet.post_to_sheet(client.user(data), client.real_name(data), client.current_time(data))

    # Need to figure out Error handling. Should have something like the below on every method. Can abstract out
    # Maybe send necessary info into method that handles responding
    if(checkedTime)
      c.say(text: "Awesome, you signed in at #{checkedTime}", channel: data.channel)
    else
      c.say(text: "We couldn't sign you in", channel: data.channel)
    end
  end


  subscribe_command 'my absences' do |client, data, match|
    # Need to have these pull from master spreadsheet to get total lates/absences
    absences = GoogleSheet.absences(client.user(data), client.real_name(data))

    client.say(text: "You've been absent #{absences} time(s) in #{user.mod}.", channel: data.channel)
  end


  subscribe_command 'my latenesses' do |client, data, match|
    # Need to have these pull from master spreadsheet to get total lates/absences
    latenesses = GoogleSheet.latenesses(client.user(data), client.real_name(data))

    client.say(text: "You've been late #{latenesses} time(s) in #{user.mod}.", channel: data.channel)
  end


end
