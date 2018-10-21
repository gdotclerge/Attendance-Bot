module GDrive
    class Session < GoogleDrive::Session
      include GDrive::Authenticate

      def self.session
        self.from_service_account_key(GDrive::Authenticate.credentials)
      end

      def get_sheet(user)
        self.spreadsheet_by_key(user.sheet_key)
      end

      def master_sheet
        self.spreadsheet_by_key(ENV['MASTER_SHEET_KEY'])[0]
      end

    end
end
