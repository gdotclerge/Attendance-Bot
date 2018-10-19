# saw this here https://github.com/dblock/slack-market/blob/master/slack-market/commands/mixins/subscribe.rb
# idea is we call subscribe_commands not command, which ensures we can run commands through this mixins
# and grab the client, adding a bunch of methods before passing it on.

# module AttendanceBot
#   module Commands
#     module Mixins
#       module Subscribe
#         extend ActiveSupport::Concern
#         # don't understand how ActiveSupport plays a role in this tbh
#
#         module ClassMethods
#           # and don't quite understand this module...
#           def subscribe_command(*values, &_block)
#             command(*values) do |client, data, match|
#               client.extend(ClientMethods)
#
#               yield client, data, match
#
#             end
#           end
#         end
#       end
#     end
#   end
# end
