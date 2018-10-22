module SlackTimelyBot
  module Commands
    module Admin
      class CheckAttendance < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin check attendance', 'admin attendance' do |client, data, _match|
        session = GDrive::Session.session
        sheet = session.get_sheet(client.user(data))
        worksheet = sheet.mod_worksheet(client.user(data).mod.number)

        client.say(text: "Checking attendance for Google sheet: _#{worksheet.title}_", channel: data.channel)

        attendance = worksheet.attendance
        # attendance => hash {all_students: [], missing: []}

        if attendance[:missing].any?
          @slack_client ||= ::Slack::Web::Client.new

          attendance[:missing].each do |student|
            slack_user = client.find_slack_user(student)

            if slack_user
              im_channel = @slack_client.im_open(user: slack_user.id)['channel']['id']
              client.say(text: "Hi :wave:\n Your instructors are checking attendance now and you haven’t checked in yet!", channel: data.channel)
              # channel needs to be changed back to im_channel when we deploy
            else
              client.say(text: "Oh no, I can’t seem to find #{student}, please check to see if their slack name is the same as their name on the attendance sheet.", channel: data.channel)
            end
          end
          client.say(text: "#{attendance[:missing].join(", ")} did not check in, I’ve sent a direct message as a reminder.", channel: data.channel)
         end
         header = "*Student*   |  Time\n--------------------"
         client.say(text: " #{header}\n #{attendance[:all_students].join("\n")}", channel: data.channel)

        end

      end
    end
  end
end
