module GDrive
    class Session < GoogleDrive::Session
      include GDrive::Authenticate

      def self.session
        session = self.from_service_account_key(GDrive::Authenticate.credentials)
        session.extend(SlackTimelyBot::AddMethods::Session)
      end


      # def valid_sheet_url?(match)
      #   # checks to see that the sheet url is valid
      #
      #   if valid
      #        match.spreadsheet_key
      #   else
      #      nil
      #    end
      #
      # end

    end
end
