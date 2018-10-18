module ClientMethods

  def permitted?(data, match)
    admin_status = self.user(data).is_admin
    self.admin_command?(match) ? admin_status : !admin_status
  end

  def user(data)
    self.store.users[data.user]
  end

  def real_name(data)
    self.user(data).real_name.downcase
  end

  def get_slack_members(data)
    self.store.channels[data.channel].members
  end

  def spreadsheet_key(match)
    str_arr = match["expression"].split("/")
    index = str_arr.index("d") + 1
    str_arr[index]
  end

  def admin_command?(match)
    match['command'].split(" ")[0] === "admin"
  end

  def current_time(data)
    Time.now.getlocal(self.user(data).tz_offset).strftime("%I:%M %p")
  end

end
