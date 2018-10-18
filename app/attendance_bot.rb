class AttendanceBot < SlackRubyBot::Bot

  def self.permitted?(client, data, match)
    admin_status = client.store.users[data.user].is_admin
    AttendanceBot.admin_command?(match) ? admin_status : !admin_status
  end

  def self.admin_command?(match)
    match['command'].split(" ")[0] === "admin"
  end

  
  # command 'my absences' do |client, data, match|
  #   user = User.find_by(slack_id: data.user)
  #   real_name = ImHereBot.real_name(client, data)
  #   absences = GoogleSheet.absences(user, real_name)
  #   client.say(text: "You've been absent #{absences} time(s) in #{user.mod}.", channel: data.channel)
  # end

  # command 'my latenesses' do |client, data, match|
  #   user = User.find_by(slack_id: data.user)
  #   real_name = ImHereBot.real_name(client, data)
  #   latenesses = GoogleSheet.latenesses(user, real_name)
  #   client.say(text: "You've been late #{latenesses} time(s) in #{user.mod}.", channel: data.channel)
  # end

  # def self.user(client, data)
  #   client.store.users[data.user]
  # end
  #
end
