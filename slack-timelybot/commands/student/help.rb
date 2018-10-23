module SlackTimelyBot
  module Commands
    module Student
      class Help < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe


        subscribe_command 'help' do |client, data, _match|
          command = _match[:expression]
          text =  if command.present?
                    help_attrs = SlackRubyBot::Commands::Support::Help.instance.find_command_help_attrs(command)
                    "*#{command}* - #{help_attrs.command_desc}"
                  else
                    general_text
                  end

          client.say(text: text, channel: data.channel)

        end

        class << self
          private

          def general_text
            bot_desc = SlackRubyBot::Commands::Support::Help.instance.bot_desc_and_commands
            other_commands_descs = SlackRubyBot::Commands::Support::Help.instance.other_commands_descs.select { |str| !str[1..5].include?("admin") }

        <<TEXT
:hourglass: *Timely Bot* :hourglass:
Attendance Bot for Flatiron School

*Commands:*
#{other_commands_descs.join("\n")}



For getting description of the command use: *help <command>*


*Contact*
DM <@U81HZTAUR> or <@U873E9HJB> if you're having any trouble!
TEXT
          end
        end

      end
    end
  end
end
