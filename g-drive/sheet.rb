module GDrive
  class Sheet < GoogleDrive::Spreadsheet
    # The spreadsheet as a whole, including all tabs

    def mod_worksheet(mod)
      #Ex. worksheet name: web-080618-Mod3
      self.worksheets.find { |worksheet| worksheet.title.include?(mod) }
    end


  end
end
