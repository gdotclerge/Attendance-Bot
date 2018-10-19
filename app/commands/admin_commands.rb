require_relative '../mixins/subscribe.rb'


class AdminCommands < AttendanceBot
  include Mixins::Subscribe

  subscribe_command 'admin set mod' do |client, data, match|
    client.slack_members(data).each do |slack_id|
      user = User.find_by(slack_id: slack_id)

      # Do we need to format it this way? Couldn't we just pass the integer in?
      user.update_attributes(mod: "Mod" + match["expression"])

      # maybe should use begin rescue for updating to make sure they actually do update. If they do, then we return how many members were actually updated
    end

    # check if spreadsheet is set
    # check if tab exists on set spreadsheet (is valid mod number?)
    client.say(text: "Updated #{client.slack_members(data).count} users to #{mod}.", channel: data.channel)
  end


  subscribe_command 'admin init' do |client, data, match|
    client.slack_members(data).each do |slack_id|
      user = User.find_or_create(slack_id: slack_id)

      user.update_attributes(sheet_key: match.spreadsheet_key)
    end

    # check if spreadsheet exists
    # Spreadsheet.exists?(sheet_key)
    client.say(text: "#{slack_members.count} were initialized.", channel: data.channel)
  end


  subscribe_command 'admin check attendance' do |client, data, match|
    attendance = GoogleSheet.check_attendance(client.user(data))
    # What's the difference between this command and admin attendance?

    client.say(text: "#{attendance}", channel: data.channel)
  end


  subscribe_command 'admin attendance' do |client, data, match|
    # need a walk through of how this works. Wondering if we can use the client given instead of creating new one below

    @slack_client ||= ::Slack::Web::Client.new
    im_channel = @slack_client.im_open(user: data.user)['channel']['id']
    students = GoogleSheet.attendance(client.user(data))
    students_str = students.select { |student| student != nil }.join(", ")

    client.say(text: "#{students.select { |student| student != nil }.join(", ")}", channel: im_channel)
  end
end
