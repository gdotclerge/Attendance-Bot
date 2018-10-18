class TeacherCommand < StudentCommand

  # ========== ADMIN COMMANDS ===============

  command 'admin test' do |client, data, match|
    client.say(text: "Currently Deployed and working", channel: data.channel)
  end

  # check if spreadsheet exists
  # Spreadsheet.exists?(sheet_key)

  command 'admin init' do |client, data, match|
    sheet_key = spreadsheet_key(match)
    slack_members = client.store.channels[data.channel].members
    slack_members.each do |slack_id|
      User.create(slack_id: slack_id, sheet_key: sheet_key, mod: "Mod1")
    end
    client.say(text: "#{slack_members.count} were initialized.", channel: data.channel)
  end

  # need to check if spreadsheet is set before set mod command
  # need to check if tab exists on set spreadsheet (is valid mod number?)

 command 'admin set mod' do |client, data, match|
   mod = "Mod"+match["expression"]
   slack_members = get_slack_members(client, data)
   slack_members.each do |slack_id|
     user = User.find_by(slack_id: slack_id)
     user.update_attributes(mod: mod)
   end
   client.say(text: "Updated #{slack_members.count} users to #{mod}.", channel: data.channel)
 end

 command 'admin attendance' do |client, data, match|
   user = User.find_by(slack_id: data.user)
   @slack_client ||= ::Slack::Web::Client.new
   im_channel = @slack_client.im_open(user: data.user)['channel']['id']
   students = student_check(GoogleSheet.attendance(user))
   if students
     client.say(text: "#{students} did not checked in", channel: im_channel)
   else
     client.say(text: "All students have checked in!", channel: im_channel)
   end
 end

 # Method not completed
 # command 'admin check attendance' do |client, data, match|
 #   user = User.find_by(slack_id: data.user)
 #   attendance = GoogleSheet.check_attendance(user)
 #   client.say(text: "#{attendance}", channel: data.channel)
 # end

end


 # ========== HELPER METHODS ===============

def get_slack_members(client, data)
 client.store.channels[data.channel].members
end

def spreadsheet_key(match)
  str_arr = match["expression"].split("/")
  index = str_arr.index("d") + 1
  str_arr[index]
end

def student_check(students)
  students_str = students.select { |student| student != nil }.join(", ")
  students_str.length > 0 ? students_str : nil
end
