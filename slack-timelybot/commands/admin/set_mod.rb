module SlackTimelyBot
  module Commands
    module Admin
      class SetMod < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin set mod' do |client, data, _match|
          failed = []
          update_success = []
          mod = _match["expression"].to_i

          client.slack_members(data).each do |slack_id|
            user = User.find_by(slack_id: slack_id)
            if(user)
              user.mod = mod
              if(user.save)
                updated_success << user
              else
                failed << slack_id
              end
            else
              failed << slack_id
            end
          end

          if(failed.length == 0)
            client.say(text: "Successfully updated all #{update_success.count} users to mod #{mod}.", channel: data.channel)
          else
            client.say(text: "Updated #{update_success.count} users to mod #{mod}. Failed to update #{failed.count} users.", channel: data.channel)
          end
        end

      end
    end
  end
end
