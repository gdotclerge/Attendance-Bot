module SlackTimelyBot
  module Commands
    module Student
      class Test < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'test' do |client, data, _match|

          client.say(text: "Student tests running", channel: data.channel)
        end

      end
    end
  end
end
