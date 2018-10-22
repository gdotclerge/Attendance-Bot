module ClientMethods

  def permitted?(data, match)
    admin_status = self.slack_user(data).is_admin
    self.admin_command?(match) ? admin_status : !admin_status
  end

  def slack_user(data)
    self.store.users[data.user]
  end

  def slack_id(data)
    data.user
  end

  def user(data)
    User.find_by(slack_id: self.slack_id(data))
  end

  def real_name(data)
    self.slack_user(data).real_name.downcase
  end

  def slack_members(data)
    self.store.channels[data.channel].members
  end

  def local_time(data)
    Time.now.getlocal(self.slack_user(data).tz_offset).strftime("%I:%M %p")
  end

  def find_slack_user(student)
    self.store.users.values.find { |user| user.real_name ? user.real_name.downcase === student.downcase : false }
  end


# ===========================
# For methods don't don't use the client they're called on, should we put those in a different file not related to clients?

  def spreadsheet_key(match)
    str_arr = match["expression"].split("/")
    index = str_arr.index("d") + 1
    str_arr[index]
  end

  def admin_command?(match)
    match['command'].split(" ")[0] === "admin"
  end

end
