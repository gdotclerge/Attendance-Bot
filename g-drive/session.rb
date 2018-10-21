module GDrive
    class Session < GoogleDrive::Session
      include GDrive::Authenticate

      def self.session
        self.from_service_account_key(GDrive::Authenticate.credentials)
      end

      def self.start
        binding.pry
      end

      def get_sheet(user)
        self.spreadsheet_by_key(user.sheet_key)
      end

    end
end
