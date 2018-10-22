module GDrive
  class Sheet < GoogleDrive::Spreadsheet
    # The spreadsheet as a whole, including all tabs

    def mod_worksheet(mod_num)
      #Ex. worksheet name: web-080618-Mod3
      mod_name = "Mod"+mod_num.to_s
      self.worksheets.find { |worksheet| worksheet.title.include?(mod_name) }
    end


  end
end
