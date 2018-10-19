module AddMethods

  module Match
    def spreadsheet_key
      str_arr = self["expression"].split("/")
      index = str_arr.index("d") + 1
      str_arr[index]
    end

    def admin_command?
      self['command'].split(" ")[0] === "admin"
    end
  end

  module Client
    def permitted?(data, match)
      admin_status = self.slack_user(data).is_admin
      match.admin_command?(match) ? admin_status : !admin_status
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

    def time(data)
      Time.now.getlocal(self.user(data).tz_offset).strftime("%I:%M %p")
    end
  end
  
end






# module ClientMethods
#
#   def permitted?(data, match)
#     admin_status = self.slack_user(data).is_admin
#     self.admin_command?(match) ? admin_status : !admin_status
#   end
#
#   def slack_user(data)
#     self.store.users[data.user]
#   end
#
#   def slack_id(data)
#     data.user
#   end
#
#   def user(data)
#     User.find_by(slack_id: self.slack_id(data))
#   end
#
#   def real_name(data)
#     self.slack_user(data).real_name.downcase
#   end
#
#   def slack_members(data)
#     self.store.channels[data.channel].members
#   end
#
#   def time(data)
#     Time.now.getlocal(self.user(data).tz_offset).strftime("%I:%M %p")
#   end


# ===========================
# For methods that don't use the client they're called on, should we put those in a different file not related to clients?
  #
  # def spreadsheet_key(match)
  #   str_arr = match["expression"].split("/")
  #   index = str_arr.index("d") + 1
  #   str_arr[index]
  # end
  #
  # def admin_command?(match)
  #   match['command'].split(" ")[0] === "admin"
  # end

# end
