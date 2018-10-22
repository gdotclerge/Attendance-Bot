module SlackTimelyBot
  module Commands
    module Admin
      class Test < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin founder' do |client, data, _match|

          client.say(text: "Presenting...https://github.com/mccoleman75225", channel: data.channel)

          # how to get it to open not on my computer....
          # Launchy.open("https://github.com/mccoleman75225")
        end

      end
    end
  end
end
