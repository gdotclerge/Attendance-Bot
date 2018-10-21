require 'sinatra/base'

module SlackTimelyBot
  class Web < Sinatra::Base
    get '/' do
      'Timely Bot is up and running.'
    end
  end
end
