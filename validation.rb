require_relative 'user_input'
require_relative 'constants'

class Validation
  include Constants
  def self.return_to_menu(which_menu)
    puts "Press Enter to return to #{which_menu} Menu..."
    UserInput.enterkey_entry
  end

  def self.find_password_from_csv(staffid)
    READ_STAFF_FILE.find { |staff| staff.include?(staffid)}[3]
  end

  def self.is_valid_staff(staffid, password)
    find_password_from_csv(staffid) == password
  end

  def self.login
    is_invalid_staff = true
    while is_invalid_staff
      puts 'Please enter your Staff ID:'
      staffid = UserInput.entry
      puts 'Please enter your Password:'
      password = UserInput.entry
      is_invalid_staff = !is_valid_staff(staffid, password)
      feedback = is_invalid_staff ? "\n #{Rainbow('Incorrect login details, please try again.').bg(:darkred)}\n " : "\n #{Rainbow('Successful login!').bg(:darkgreen)}\n "
      system 'clear'
      puts feedback
    end
    staffid
  end
end