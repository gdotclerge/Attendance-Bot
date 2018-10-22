module SlackTimelyBot
  module Commands
    module Admin
      class SetMod < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin set mod' do |client, data, _match|

          failed = []
          cohort = Cohort.find_by(name: client.channel_name(data))

          # Need to check to make sure they've initialized the cohort first

          client.slack_members(data).each do |slack_id|
            # Should only update non-admin users
            user = User.find_by(slack_id: slack_id)
            if(user)
              user.update_attributes(mod_id: mod.id)
            else
              failed << slack_id
            end
          end

          if(failed.empty?)
            client.say(text: "Successfully updated all #{mod.users.count} users to mod #{mod.number}.", channel: data.channel)
          else
            client.say(text: "Updated #{update_success.count} users to mod #{mod.number}. Failed to update #{failed.count} users.", channel: data.channel)
            # This should print out a list of all names that failed. See Garry's list printing for Check Attendance
          end
        end

      end
    end
  end
end
