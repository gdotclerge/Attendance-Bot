class StudentCommand < AttendanceBot

  command 'present' do |client, data, match|
    name = real_name(client, data)
    user = User.find_by(slack_id: data.user)
    time = current_time(client, data)
    checkedTime = GoogleSheet.post_to_sheet(user, name, time)
    if checkedTime
      client.say(text: "Awesome, you signed in at #{time}", channel: data.channel)
    else
      client.say(text: "We couldn't sign you in", channel: data.channel)
    end
  end

end


# ========== HELPER METHODS ===============

def real_name(client, data)
  self.user(client, data).real_name.downcase
end

def current_time(client, data)
  Time.now.getlocal(client.store.users[data.user].tz_offset).strftime("%I:%M %p")
end
