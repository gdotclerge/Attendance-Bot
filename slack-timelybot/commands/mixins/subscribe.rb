module SlackTimelyBot
  module Commands
    module Mixins
      module Subscribe
        extend ActiveSupport::Concern
        # don't understand how ActiveSupport plays a role in this tbh

        module ClassMethods
          # and don't quite understand this module...think it has something to do with ActiveSupport::Concern tho
          def subscribe_command(*values, &_block)
            command(*values) do |client, data, match|

              client.extend(AddMethods::Client)
              match.extend(AddMethods::Match)

              yield client, data, match

            end
          end

        end
      end
    end
  end
end
