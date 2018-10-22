module SlackTimelyBot
  module Commands
    module Admin
      class Update < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin test' do |client, data, _match|
          client.say(text: "Admin tests running", channel: data.channel)
        end

      end
    end
  end
end
