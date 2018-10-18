class AttendanceBot < SlackRubyBot::Bot








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
  #
  #   client.say(text: "Admin// Currently Deployed and working", channel: data.channel)
  # end




  # ====== Testing Commands ========

  command 'admin test' do |client, data, match|
    client.say(text: "Admin// Currently Deployed and working", channel: data.channel)
  end

  command 'admin test' do |client, data, match|
    client.say(text: "Student// Currently Deployed and working", channel: data.channel)
  end

end
