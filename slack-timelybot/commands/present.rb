module SlackTimelyBot
  module Commands
    class Present < SlackRubyBot::Commands::Base
      include SlackTimelyBot::Commands::Mixins::Subscribe

      subscribe_command 'present', 'here' do |client, data, _match|
        # don't quite understand the use of _ in _match
        checkedTime = GoogleSheet.post_to_sheet(client.user(data), client.real_name(data), client.current_time(data))

        # Need to figure out Error handling. Should have something like the below on every method. Can abstract out
        # Maybe send necessary info into method that handles responding
        if(checkedTime)
          c.say(text: "Awesome, you signed in at #{checkedTime}", channel: data.channel)
        else
          c.say(text: "We couldn't sign you in", channel: data.channel)
        end

      end

    end
  end
end
