module SlackTimelyBot
  module Commands
    module Student
      class Help < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'help' do |client, data, _match|

          text = <<-HEREDOC
          *Direct Message Commands*
          _Info_
          `@timelybot help`: to see help resources and how to contact the TimelyBot Team

          _Everyday tasks_
          `@timelybot present`: Checks you in for the day at the time you execute the command.
          `@timelybot standing`: Returns a list of all your lates and absences.

          _Extras_
          `@timelybot founder`: pay homage.

          *Contact*
          DM @garry or @jonathan if you're having any trouble!
          HEREDOC

          client.say(text: text, channel: data.channel)

        end

      end
    end
  end
end
