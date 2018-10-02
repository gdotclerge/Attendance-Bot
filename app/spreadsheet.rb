require 'bundler'
require 'pry'
Bundler.require

class GoogleSheet < GoogleDrive::Session

  @@session = GoogleSheet.from_service_account_key("config/config.json")

  def self.post_to_sheet(user, real_name)
    self.worksheet(user)

    x = find_todays_date_by_locating_the_row
    y = find_the_person_submitting_the_request_for_column(entered_name)

    worksheet(user)[y,x] = Time.now.strftime("%H:%M")
    worksheet.save
  end


  # def authorizate_worksheet()
  #   # binding.pry
  #   # session = GoogleDrive::Session.from_service_account_key("../config/config.json")
  #   # session = GoogleDrive::Session.from_service_account_key("client_secret.json")
  #   binding.pry

  #   return spreadsheet.worksheets.first
  # end

  # def return_session
  #   # session = GoogleSheet.from_service_account_key("config.json")
  #   binding.pry
  # end


  def read_cells()
    worksheet = authorizate_worksheet
    worksheet.rows.each { |row| puts row.first(6).join(" | ") }
  end

  def find_todays_date_by_locating_the_row()
    worksheet = authorizate_worksheet
    counter = 0
    worksheet.rows(10).each do |block|
      block.each do |cell|
        counter += 1
        if cell == "9/18/2018"
          return counter
        end
      end
    end
  end

  def find_the_person_submitting_the_request_for_column(entered_name)

    worksheet = authorizate_worksheet
    counter = 12
    while counter < 50 do
      if worksheet.rows[counter][0] == entered_name
        return counter + 1
      end
      counter += 1
    end
  end



  def self.worksheet(user)
    spreadsheet = @@session.spreadsheet_by_key(user.sheet_key)
    spreadsheet.worksheets.find { |worksheet| worksheet.title.include?("Mod1") }
    # spreadsheet.worksheets.find { |worksheet| worksheet.title.include?(user.mod) }

  end


end

# Pry.start
