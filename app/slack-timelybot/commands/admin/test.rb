module SlackTimelyBot
  module Commands
    module Admin
      class Test < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin test' do |client, data, _match|



          client.say(text: "Deployed and working.", channel: data.channel)
        end

      end
    end
  end
end
