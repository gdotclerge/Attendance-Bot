module SlackTimelyBot
  module Commands
    module Admin
      class Init < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin init' do |client, data, _match|
          session = GDrive::Session.session

          # sheet_key = session.valid_sheet_url?(match)
          # if sheet_key
            # continue
          # else
          #   client.say(text: "I'm sorry, that is not a valid Google Sheet. It needs to be a Google Sheet that starts with "Attendance Register - ", channel: data.channel)
          # end

          failed = []
          update_success = []

          sheet_key = _match.spreadsheet_key
          sheet = Sheet.find_or_create(sheet_key)
          sheet.users = []

          client.slack_members(data).each do |slack_id|

            user = User.find_or_create(slack_id: slack_id)
            if(user)
              sheet.users << user
            else

            end
          end

          # need to check if spreadsheet exists example Spreadsheet.exists?(sheet_key)
          client.say(text: "#{slack_members.count} were initialized.", channel: data.channel)
        end

      end
    end
  end
end


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
