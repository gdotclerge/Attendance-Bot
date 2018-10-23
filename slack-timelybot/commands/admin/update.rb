module SlackTimelyBot
  module Commands
    module Admin
      class Update < SlackRubyBot::Commands::Base
        include SlackTimelyBot::Commands::Mixins::Subscribe
        # admin update @michael #nyc-mhtn-web-080618
        subscribe_command 'admin update' do |client, data, _match|

          args = _match['expression'].gsub('<', "").gsub('>', "").split(" ")
          cohort_name = args.find {|str| str.include?("#")}.split("|")[1]
          cohort = Cohort.find_or_create_by(name: cohort_name)

          args.each do |arg|
            if(arg.include?("@"))
              user = User.find_by(slack_id: arg[1..-1])
              user.update_attributes(cohort_id: cohort.id)
            end
          end

          client.say(text: "Updated #{args.count-1} users to #{cohort.name}.", channel: data.channel)
        end

      end
    end
  end
end
