class GoogleSheet < GoogleDrive::Session

  def self.google_credentials
    if ENV['GDRIVE_AUTH']
      StringIO.new(Base64.decode64(ENV['GDRIVE_AUTH']))
    else
      'config/config.json'
    end
  end

  @@session = GoogleSheet.from_service_account_key(GoogleSheet.google_credentials)
  # continues to fail silently, unable to get an error or nil back to the command class
  # def self.valid_spreadsheet?(sheet_key)
  #   @@session.file_by_id(sheet_key) ? true : false
  # end

  def self.post_to_sheet(user, name, time)
    sheet = self.worksheet(user)
    x = self.find_x(sheet)
    y = self.find_y(sheet, name)
    if(x && y)
      sheet[y,x] = time
      let x = sheet.save
      time
    else
      nil
    end
  end


  def self.find_x(sheet)
    index = sheet.rows[8].find_index do |cell|
      cell.include?(Time.now.strftime("%m/%-d/%y"))
      # cell.include?("10/19/18")
    end
    index ? index + 1 : nil
  end


  def self.find_y(sheet, real_name)
    names_arr = sheet.rows.map { |row| row[0] }
    index = names_arr.find_index do |name|
      name.downcase == real_name
    end
    index ? index + 1 : nil
  end


  def self.worksheet(user)
    spreadsheet = @@session.spreadsheet_by_key(user.sheet_key)
    spreadsheet.worksheets.find { |worksheet| worksheet.title.include?(user.mod) }
  end


  def self.absences(user, real_name)
    sheet = GoogleSheet.worksheet(user)
    rows = sheet.rows[GoogleSheet.find_y(sheet, real_name) - 1][4..-1]
    rows.select { |time| time == "absent" }.count

  end

  def self.latenesses(user, real_name)
    sheet = GoogleSheet.worksheet(user)
    rows = sheet.rows[GoogleSheet.find_y(sheet, real_name) - 1][4..-1]
    rows.select do |time|
      time.length > 0 ? Time.parse(time) > Time.parse("9:15 AM") : false
    end.count
  end

  def self.attendance(user)
    sheet = self.worksheet(user)
    index = self.find_x(sheet) - 1
    student_arr = sheet.rows[9..-3]
    missing = []
    all_students = []
    sl = student_arr.each do |sa|
      all_students.push("*#{sa[0]}*  |  #{sa[index]}")
      if sa[index].length < 1
         missing.push(sa[0])
      end
    end
    { "all_students" => all_students, "missing" => missing }
  end

  def master_sheet
    spreadsheet = @@session.spreadsheet_by_key('1E4xZZnDXIlrH7EYP6xMMEaXrN_qQVbayJCiLEt3rBN0')
    spreadsheet.worksheets[0]
  end

# sheet.rows[9..-1]



# have bot warn student 1 absence away from attendance violation
# have bot warn student how many lateness away from violation
# trigger a slack to Brandon to know once a student receives warning

# core.reject { |_,fruit,_| filter.include?(fruit) }


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

  #   counter = 12
  #   while counter < 50 do
  #     if worksheet.rows[counter][0] == entered_name
  #       return counter + 1
  #     end
  #     counter += 1
  #   end
  #
  # end

  def read_cells()
    worksheet = authorizate_worksheet
    worksheet.rows.each { |row| puts row.first(6).join(" | ") }
  end

  # def find_todays_date_by_locating_the_row()
  #   worksheet = authorizate_worksheet
  #   counter = 0
  #   worksheet.rows(10).each do |block|
  #     block.each do |cell|
  #       counter += 1
  #       if cell == "9/18/2018"
  #         return counter
  #       end
  #     end
  #   end
  # end

  # def find_the_person_submitting_the_request_for_column(entered_name)
  #
  #   worksheet = authorizate_worksheet
  #   counter = 12
  #   while counter < 50 do
  #     if worksheet.rows[counter][0] == entered_name
  #       return counter + 1
  #     end
  #     counter += 1
  #   end
  # end

end
