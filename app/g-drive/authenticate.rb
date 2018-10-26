module GDrive
  module Authenticate

    def self.credentials
      if ENV['GDRIVE_AUTH']
        StringIO.new(Base64.decode64(ENV['GDRIVE_AUTH']))
      else
        'config/config.json'
      end
    end

  end
end
