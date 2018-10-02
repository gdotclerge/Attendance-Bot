require 'bundler'
require 'pry'
Bundler.require

def authorizate_worksheet()
  # binding.pry
  session = GoogleDrive::Session.from_service_account_key("config.json")
  # session = GoogleDrive::Session.from_service_account_key("client_secret.json")
  binding.pry
  spreadsheet = session.spreadsheet_by_title("test")
  return spreadsheet.worksheets.first
end


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

def put_cells(entered_name)
  worksheet = authorizate_worksheet
  x = find_todays_date_by_locating_the_row
  y = find_the_person_submitting_the_request_for_column(entered_name)

  worksheet[y,x] = Time.now.strftime("%H:%M")
  worksheet.save
end


def save_spreadsheet
  
end