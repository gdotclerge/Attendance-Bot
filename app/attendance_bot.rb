require_relative './mixins/subscribe.rb'

class AttendanceBot < SlackRubyBot::Bot
  include Mixins::Subscribe

  # Format should be:
  #
  # command 'some command' do |client, data, match|
  #   extend extra methods to client
  #   client.extends(ClientMethods)
  #
  #   Call on some method to do an action/process
  #   msg = GoogleSheet.someaction(data)
  #
  #   respond with appropriate message (either error or success message)
  #   client.respond(msg)
  #   => "You can't do that action" or "Great your signed in"
  #
  # end




  # ====== Testing Commands ========

  subscribe_command 'admin test' do |client, data, match|
    client.say(text: "Admin// Currently Deployed and working", channel: data.channel)
  end

  command 'test' do |client, data, match|
    client.say(text: "Student// Currently Deployed and working", channel: data.channel)
  end

end
