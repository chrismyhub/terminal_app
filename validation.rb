require 'csv'

class Validation

  def self.staff_login(staffid, password)
    data_staff = CSV.read('staff.csv')
        if (data_staff.find { |staff| staff.include?(staffid)}[3]) == password
          puts "Login Successful!"
        else
          puts "Invalid Staff login, please try again."
        end
  end

  def self.is_valid_staff(staffid, password)
    data_staff = CSV.read('staff.csv')
      (data_staff.find { |staff| staff.include?(staffid)}[3]) == password
  end
end