module SlackTimelyBot
  module Commands
    module Student
      class Present < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        help do
          title "present"
          desc "checks you in for the day"
          long_desc "Checks you in and responds with the time you checked in. Example - Awesome, you signed in at 9:00AM."
        end

        subscribe_command 'present', 'here', 'signin' do |client, data, _match|
          if client.is_student?(data, _match)
            client.say(text: "It looks like you're an admin, not a student. Only students can sign in. Type `admin help` to see what kinds of commands you can run.", channel: data.channel)
          else
            session = GDrive::Session.session
            sheet = session.get_sheet(client.user(data))
            worksheet = sheet.mod_worksheet(client.user(data).mod.number)
            time = client.current_time(data)
            real_name = client.real_name(data)

            checked_time = worksheet.post(real_name, time)

            if(checked_time)
              client.say(text: "Awesome, you signed in at #{checked_time}", channel: data.channel)
            else
              client.say(text: "We couldn't sign you in. Please DM a TCF to resolve.", channel: data.channel)
              # Should also contact admin for this class with info about why they couldn't sign in
            end
          end
        end

      end
    end
  end
end
