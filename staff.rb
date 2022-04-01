require 'csv'
require_relative 'constants'
require_relative 'validation'

class Staff
  attr_reader :id, :name, :role, :password

  include Constants

  def initialize(id, name, role, password)
    @id = id
    @name = name
    @role = role
    @password = password
  end

  def self.find_staff_in_csv(staffid, column_index)
    READ_STAFF_FILE.find { |values| values.include?(staffid)}[column_index]
  end

  # WRITE METHOD FOR UPDATE NAME
  def self.input_name(new_name)
    puts "Please enter your#{new_name}name:"
    UserInput.entry.capitalize
  end

  # WRITE A METHOD FOR DELETE STAFF ID (WHEN I DELETE A STAFF OFF THE CSV FILE)
  def self.create_id(new_staff_name)
    "#{new_staff_name.gsub(/[[:space:]]/, '')}1"
  end

  def self.input_role
    role_entered = ' '

    while role_entered != 'M' && role_entered != 'T'
      puts "Please enter your role: \n (Please enter either M (for MANAGER) or T (for TEAM MEMBER)"
       role_entered = UserInput.entry.upcase
         if role_entered == 'M'
           max_leave_allocated = 'MANAGER_MAX_LEAVE_ALLOCATED'
         elsif role_entered == 'T'
           max_leave_allocated = 'TEAM_MEMBER_MAX_LEAVE_ALLOCATED'
         else
           system "clear"
          puts "Invalid entry, please try again."
         end
    end
    return max_leave_allocated
  end

  # CREATE METHOD FOR UPDATE PASSWORD (DELETING OF PASSWORD HANDLED BY DELETE STAFF)
  def self.input_password
    puts 'Please enter a password:'
    UserInput.entry
  end

  # CREATE NEW METHOD FOR UPDATE AND DELETE EXISTING STAFF DETAILS 
  def self.create_new
    new_staff_name = input_name(' ')
    new_staff_id = create_id(new_staff_name)
    new_staff_role = input_role
    new_staff_password = input_password
    Staff.new(new_staff_id, new_staff_name, new_staff_role, new_staff_password)
  end

  def self.write_to_csv
    File.open('staff.csv', 'w') do |f|
      f.write(EDIT_STAFF_FILE.to_csv)
    end
  end

  def self.delete_existing(staffid)
    EDIT_STAFF_FILE.delete_if do |row|
      row[:staffid] == staffid
    end

    write_to_csv
    puts 'Successfully deleted your account!'
  end

  def self.update_existing(staffid)
    new_name = input_name(" new ")

    # FIND EXISTING ROLE
    staff_role = find_staff_in_csv(staffid, 2)
    staff_password = Validation.find_password_from_csv(staffid)
  
    # OPEN STAFF CSV File
    CSV.open('staff_output.csv', 'a') do |csv|
    # INSERT NEW NAME AND ADD NEW STAFF DETAILS TO STAFF OUTPUT CSV
    csv << [staffid, new_name, staff_role, staff_password]
    end
    # add_to_staff_csv('staff_output.csv', staff_role)

    # DELETE OLD STAFF DETAILS

    # CALL STAFF CSV FILE
    data_staff = CSV.table('staff.csv')

    # DELETE ROW IF STAFF NAME STAFF ID
    data_staff.delete_if do |row|
    row[:staffid] == staffid
    end

    # WRITE UPDATED STAFF CSV FILE
    File.open('staff.csv', 'w') do |f|
    f.write(data_staff.to_csv)
    end

    # MOVE UPDATED DETAILS TO EXISTING LIST

    # OPEN STAFF OUTPUT CSV File
    data_staff_new = CSV.read('staff_output.csv')
    # LOOK FOR EXISTING STAFF ID FROM OUTPUT CSV
    staff_id_new = data_staff_new.find { |id| id.include?(staffid)}[0]
    # LOOK FOR UPDATED NAME FROM OUTPUT CSV
    staff_name_new = data_staff_new.find { |name| name.include?(staffid)}[1]
    # LOOK FOR EXISTING ROLE FROM OUTPUT CSV
    staff_role_new = data_staff_new.find { |role| role.include?(staffid)}[2]
    # LOOK FOR EXISTING PASSWORD FROM OUTPUT CSV
    staff_password_new = data_staff_new.find { |password| password.include?(staffid)}[3]
    
    #OPEN EXISTING STAFF CSV
    CSV.open('staff.csv', 'a') do |csv|
    # COPY UPDATED DETAILS FROM OUTPUT CSV TO EXISTING STAFF CSV
    csv << [staff_id_new, staff_name_new, staff_role_new, staff_password_new]
    end


    # DELETE OUTPUT CSV CONTENTS

    # CALL STAFF OUTPUT CSV FILE
    data_staff = CSV.table('staff_output.csv')

    # DELETE ROW IF STAFF NAME STAFF ID IN STAFF OUTPUT CSV
    data_staff.delete_if do |row|
    row[:staffid] == staffid
    end

    # WRITE UPDATED STAFF OUTPUT CSV FILE
    File.open('staff_output.csv', 'w') do |f|
    f.write(data_staff.to_csv)
    end

    puts "You have successfully changed your Name!"

  end

  # CREATE METHOD FOR UPDATING AND DELETING EXISTING STAFF DEATILS FROM CSV
  def self.add_to_staff_csv(file, staff)
    CSV.open(file, 'a') do |csv|
      csv << [staff.id, staff.name, staff.role, staff.password]
    end
  end
end