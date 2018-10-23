module SlackTimelyBot
  module Commands
    module Admin
      class Test < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin test' do |client, data, _match|



          client.say(text: "You're in #{client.channel_name(data)}", channel: data.channel)
        end

      end
    end
  end
end
