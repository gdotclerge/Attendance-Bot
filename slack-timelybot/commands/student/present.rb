module SlackTimelyBot
  module Commands
    module Student
      class Present < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'present', 'here', 'signin' do |client, data, _match|
          if client.is_student?(data, _match)
            client.say(text: "It looks like you're an admin, not a student. Only students can sign in.", channel: data.channel)
          else
            session = GDrive::Session.start
            sheet = session.get_sheet(client.user(data))
            worksheet = sheet.mod_worksheet(mod)
            time = client.current_time(data)
            real_name = client.real_name(data)

            checked_time = worksheet.post(real_name, time)

            if(checked_time)
              client.say(text: "Awesome, you signed in at #{checked_time}", channel: data.channel)
            else
              client.say(text: "We couldn't sign you in", channel: data.channel)
              # Should also contact admin for this class with info about why they couldn't sign in
            end
          end
        end

      end
    end
  end
end
