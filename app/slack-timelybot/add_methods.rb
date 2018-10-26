module SlackTimelyBot
  module AddMethods

    module Worksheet
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


      def attendance
        # Returns hash with key of all students and missing
         index = self.find_x - 1
         student_arr = self.rows[9..-3]

         attend_hash = {
           all_students: [],
           missing: []
         }

         student_arr.each do |student_row|
           # ex. student_row => ["name", time, time, time]
           attend_hash[:all_students].push("*#{student_row[0]}*  |  #{student_row[index]}")
           if student_row[index].length < 1
              attend_hash[:missing].push(student_row[0])
           end
         end

         attend_hash
      end


      def read_cells
        # What does this do?
        self.rows.each {|row| puts row.first(6).join(" | ")}
      end

    end

    module Sheet
      def mod_worksheet(mod_num)
        #Ex. worksheet name: web-080618-Mod3
        mod_name = "Mod"+mod_num.to_s
        worksheet = self.worksheets.find { |worksheet| worksheet.title.include?(mod_name) }
        worksheet.extend(SlackTimelyBot::AddMethods::Worksheet)
      end
    end

    module Session
      def get_sheet(user)
        sheet = self.spreadsheet_by_key(user.sheet.sheet_key)
        sheet.extend(SlackTimelyBot::AddMethods::Sheet)
      end

      def master_sheet
        self.spreadsheet_by_key(ENV['MASTER_SHEET_KEY'])[0]
      end
    end

    module Match
      def spreadsheet_key
        str_arr = self["expression"].split("/")
        index = str_arr.index("d") + 1
        str_arr[index]
      end

      def admin_command?
        self['command'].split(" ")[0] === "admin"
      end
    end

    module Client
      def is_student?(data, match)
        !self.permitted?(data, match)
      end

      def permitted?(data, match)
        admin_status = self.slack_user(data).is_admin
        match.admin_command? ? admin_status : !admin_status
      end

      def slack_user(data)
        self.store.users[data.user]
      end

      def find_slack_user(student)
        self.store.users.values.find { |user| user.real_name ? user.real_name.downcase === student.downcase : false }
      end

      def slack_id(data)
        data.user
      end

      def user(data)
        User.find_by(slack_id: self.slack_id(data))
      end

      def real_name(data)
        self.slack_user(data).real_name.downcase
      end

      def slack_members(data)
        self.store.channels[data.channel].members
      end

      def channel_name(data)
        self.store.channels[data.channel].name
      end

      def current_time(data)
        Time.now.getlocal(self.user(data).tz_offset).strftime("%I:%M %p")
      end
    end

  end
end






# module ClientMethods
#
#   def permitted?(data, match)
#     admin_status = self.slack_user(data).is_admin
#     self.admin_command?(match) ? admin_status : !admin_status
#   end
#
#   def slack_user(data)
#     self.store.users[data.user]
#   end
#
#   def slack_id(data)
#     data.user
#   end
#
#   def user(data)
#     User.find_by(slack_id: self.slack_id(data))
#   end
#
#   def real_name(data)
#     self.slack_user(data).real_name.downcase
#   end
#
#   def slack_members(data)
#     self.store.channels[data.channel].members
#   end
#
#   def time(data)
#     Time.now.getlocal(self.user(data).tz_offset).strftime("%I:%M %p")
#   end


# ===========================
# For methods that don't use the client they're called on, should we put those in a different file not related to clients?
  #
  # def spreadsheet_key(match)
  #   str_arr = match["expression"].split("/")
  #   index = str_arr.index("d") + 1
  #   str_arr[index]
  # end
  #
  # def admin_command?(match)
  #   match['command'].split(" ")[0] === "admin"
  # end

# end
