module GDrive
  class Worksheet < GoogleDrive::Worksheet

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

      index ? index + 1 : nil
    end

    def post_time(real_name)
      time = 

      x = self.find_x
      y = self.find_y(real_name)

      if(x && y)
        self[y,x] = time
    end

  end
end
