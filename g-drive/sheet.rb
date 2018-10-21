module GDrive
  class Sheet < GoogleDrive::Spreadsheet

    def mod_worksheet(mod)
      #Ex. worksheet name: web-080618-Mod3
      self.worksheets.find { |worksheet| worksheet.title.include?(mod) }
    end


  end
end
