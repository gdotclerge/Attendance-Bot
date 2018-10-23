module SlackTimelyBot
  module Commands
    module Admin
      class SetMod < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin set mod' do |client, data, _match|
        
          cohort = Cohort.find_by(name: client.channel_name(data))
          cohort.update_attributes(mod: _match['expression'].to_i )
          client.say(text: "Successfully updated #{cohort.name} to mod #{cohort.mod}.", channel: data.channel)

        end

      end
    end
  end
end
