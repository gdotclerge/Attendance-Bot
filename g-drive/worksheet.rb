module GDrive
  class Worksheet < GoogleDrive::Worksheet
    # Worksheet is the actual tab on a particular spreadsheet

    def find_x
      index = self.rows[8].find_index do |cell|
        cell.include?(Time.now.strftime("%m/%-d/%y"))
      end

      # If we can't find the date, return nil
      index ? index + 1 : nil
    end

    def find_y(real_name)
      names_arr = self.rows.map { |row| row[0] }

      index = names_arr.find_index do |name|
        name.downcase == real_name
      end

      # If we can't find the name, return nil
      index ? index + 1 : nil
    end

    def post(real_name, time)
      x = self.find_x
      y = self.find_y(real_name)

      if(x && y)
        self[y,x] = time
        let x = sheet.save
        time
      else
        nil
      end
    end

    def latenesses(user, real_name)
      # check to see if it's being called on the master sheet first?

    end

    def absences(user, real_name)
      # check to see if it's being called on the master sheet first?

    end

    def attendance
      index = self.find_x
      students = self.rows[9..-3]

      test = students.map do |student|
        if (student[index].length < 1)
          student[0]
        end
      end
    end

    def read_cells
      # What does this do?
      self.rows.each {|row| puts row.first(6).join(" | ")}
    end

  end
end
