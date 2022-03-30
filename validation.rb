require 'csv'
require_relative 'user_input'

class Validation

  def self.is_valid_staff(staffid, password)
    data_staff = CSV.read('staff.csv')
      (data_staff.find { |staff| staff.include?(staffid)}[3]) == password
  end

  def self.login
    is_invalid_staff = true
    # CHECK FOR INVALID STAFF ID AND PASSWORD COMBO
    while is_invalid_staff
      system "clear"
      puts "Please enter your Staff ID:"
      staffid = UserInput.entry
      puts "Please enter your Password:"
      password = UserInput.entry
      is_invalid_staff = !(is_valid_staff(staffid, password))
      feedback = is_invalid_staff ? "Incorrect login details, please try again." : "Successful login!"
      puts feedback
    end
    staffid
  end
end