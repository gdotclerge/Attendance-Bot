module SlackTimelyBot
  module Commands
    module Admin
      class Init < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin init' do |client, data, _match|
          session = GDrive::Session.session

          # need to check if spreadsheet exists example Spreadsheet.exists?(sheet_key)
          # sheet_key = session.valid_sheet_url?(match)
          # if sheet_key
            # continue
          # else
          #   client.say(text: "I'm sorry, that is not a valid Google Sheet. It needs to be a Google Sheet that starts with "Attendance Register - ", channel: data.channel)
          # end

          sheet_key = _match.spreadsheet_key

          sheet = Sheet.create(sheet_key: sheet_key)
          cohort = Cohort.create(name: client.channel_name(data), mod: 1)

          client.slack_members(data).each do |slack_id|
            # Should only update non-admin users
            user = User.find_or_create_by(slack_id: slack_id)
            user.update_attributes(sheet_id: sheet.id, cohort_id: cohort.id)
          end

          client.say(text: "Successfully updated all #{sheet.users.count} users in #{cohort.name} to mod #{cohort.mod}.", channel: data.channel)
        end

      end
    end
  end
end
