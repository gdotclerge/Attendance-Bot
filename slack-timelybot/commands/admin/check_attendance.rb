module SlackTimelyBot
  module Commands
    module Admin
      class CheckAttendance < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin check attendance' do |client, data, _match|
          session = GDrive::Session.session
          sheet = session.get_sheet(client.user(data))
          worksheet = sheet.mod_worksheet(client.user(data).mod.number)

          client.say(text: "Checking attendnace for Google sheet: _#{worksheet.title}_", channel: im_channel)
          
          students = worksheet.attendance

          @slack_client ||= ::Slack::Web::Client.new

          student_id = client.store.users.values.select do |user|
            user.real_name ? user.real_name == students[0] : false
          end[0].id

          im_channel = @slack_client.im_open(user: data.user)['channel']['id']
          student_channel = @slack_client.im_open(user: student_id)['channel']['id']

          if students.length > 0
            client.say(text: "#{students.join(", ")} did not check in, I've sent them a DM reminder", channel: im_channel)
            client.say(text: "Whoa, instructors are checking attendance, make sure you check in!", channel: student_channel)
          else
            client.say(text: "Nice! Everyone checked in!", channel: im_channel)
          end

        end

      end
    end
  end
end
