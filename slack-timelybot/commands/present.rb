module SlackTimelyBot
  module Commands
    class Present < SlackRubyBot::Commands::Base
      include SlackTimelyBot::Commands::Mixins::Subscribe

      subscribe_command 'present', 'here' do |client, data, _match|
        session = GDrive::Session.start
        sheet = session.get_sheet(client.user(data))
        worksheet = sheet.mod_worksheet(mod)
        time = client.current_time(data)

        # Save Mem Ideas:
        #   use ||= for session?
        #   use symbols for variables?

        # checkedTime = worksheet.post_to_sheet(client.user(data), client.real_name(data), client.current_time(data))
        #
        # # Need to figure out Error handling. Should have something like the below on every method. Can abstract out
        # # Maybe send necessary info into method that handles responding
        # if(checkedTime)
        #   c.say(text: "Awesome, you signed in at #{checkedTime}", channel: data.channel)
        # else
        #   c.say(text: "We couldn't sign you in", channel: data.channel)
        # end

        if client.is_student?(data, _match)
          client.say(text: "You're not a student...", channel: data.channel)
        else
          client.say(text: "You're a student.", channel: data.channel)
        end
      end

    end
  end
end
