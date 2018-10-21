module SlackTimelyBot
  module Commands
    module Student
      class Help < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe

        subscribe_command 'admin help' do |client, data, _match|

          text = <<-HEREDOC
          *Channel Commands*
          `/invite @heytaco`: to invite me to channels

          *Direct Message Commands*
          _Setup your class_
          `@timelybot help`: to see help resources and how to contact the TimelyBot Team
          `@timelybot admin set mod <Mod Number (integer)>`: to set the mod number for all the members of a particular channel. Only works in official student channels.
          `@timelybot admin init <URL to Google Attendance Sheet>`: to initialize a cohort and assign their Google Attendance Spreadsheet for all students in that cohort. Only works in official student channels.
          `@timelybot admin update`: applies the spreadsheet ID of admin user to all students in that cohort. Must be called by TCF.

          _Everyday tasks_
          `@timelybot admin check attendance`: returns list of everyone in channel in two columns - those who have checked in for that day and those who haven't yet. Only works in official student channels.
          `@timelybot admin check status`: returns table of everyone who is close and in violation of attendance policy.

          _Everyday tasks_
          `@timelybot admin founder`: pay homage.

          *Contact*
          DM @garry or @jonathan if you're having any trouble!
          HEREDOC

          client.say(text: text, channel: data.channel)

        end

      end
    end
  end
end
