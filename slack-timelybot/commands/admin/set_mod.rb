module SlackTimelyBot
  module Commands
    module Admin
      class SetMod < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        help do
          title "admin set mod"
          desc "set cohort to the mod given ex. `admin set mod 2`"
          long_desc "This command accepts an argument of a number. This will change the cohort to the mod given. This command should be used when students transition into a new mod. ex. `admin set mod 2`"
        end

        subscribe_command 'admin set mod' do |client, data, _match|

          cohort = Cohort.find_by(name: client.channel_name(data))
          cohort.update_attributes(mod: _match['expression'].to_i )
          client.say(text: "Successfully updated #{cohort.name} to mod #{cohort.mod}.", channel: data.channel)

        end

      end
    end
  end
end
