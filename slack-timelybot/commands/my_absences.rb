module SlackTimelyBot
  module Commands
    class MyAbsences < SlackRubyBot::Commands::Base
      include SlackTimelyBot::Commands::Mixins::Subscribe

      subscribe_command 'my absences', 'absences' do |client, data, _match|
        # Need to have these pull from master spreadsheet to get total lates/absences
        absences = GoogleSheet.absences(client.user(data), client.real_name(data))

        client.say(text: "You've been absent #{absences} time(s) in #{user.mod}.", channel: data.channel)
      end

    end
  end
end
