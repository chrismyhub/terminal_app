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


  def self.input_name(new_name)
    puts "Please enter your#{new_name}name:"
    UserInput.entry.capitalize
  end

  
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


  def self.input_password(new_password)
    puts "Please enter #{new_password} password:"
    UserInput.entry
  end

 
  def self.create_new
    new_staff_name = input_name(' ')
    new_staff_id = create_id(new_staff_name)
    new_staff_role = input_role
    new_staff_password = input_password('a')
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
    puts "\n #{Rainbow('Successfully deleted your account!').bg(:darkgreen)}\n "
    Validation.return_to_menu("Main")
    Main.run
  end

  def self.update_name(staffid)
    new_name = input_name(" new ")

    staff_role = find_staff_in_csv(staffid, 2)
    staff_password = Validation.find_password_from_csv(staffid)

    CSV.open('staff_output.csv', 'a') do |csv|
    csv << [staffid, new_name, staff_role, staff_password]
    end

    EDIT_STAFF_FILE.delete_if do |row|
    row[:staffid] == staffid
    end

    File.open('staff.csv', 'w') do |f|
    f.write(EDIT_STAFF_FILE.to_csv)
    end

    CSV.open('staff.csv', 'a') do |csv|

    csv << [staffid, new_name, staff_role, staff_password]
    end

    data_staff = CSV.table('staff_output.csv')

    data_staff.delete_if do |row|
    row[:staffid] == staffid
    end

    File.open('staff_output.csv', 'w') do |f|
    f.write(data_staff.to_csv)
    end

    puts "\n #{Rainbow('You have successfully changed your Name!').bg(:darkgreen)}\n "
    Validation.return_to_menu('Main')
    Main.run

  end

  def self.update_password(staffid)
    new_password = input_password('new')

    staff_role = find_staff_in_csv(staffid, 2)
    staff_name = find_staff_in_csv(staffid, 1)

    CSV.open('staff_output.csv', 'a') do |csv|
      csv << [staffid, staff_name, staff_role, new_password]
      end

      EDIT_STAFF_FILE.delete_if do |row|
      row[:staffid] == staffid
      end

      File.open('staff.csv', 'w') do |f|
      f.write(EDIT_STAFF_FILE.to_csv)
      end

      CSV.open('staff.csv', 'a') do |csv|
   
      csv << [staffid, staff_name, staff_role, new_password]
      end

      data_staff = CSV.table('staff_output.csv')

      data_staff.delete_if do |row|
      row[:staffid] == staffid
      end

      File.open('staff_output.csv', 'w') do |f|
      f.write(data_staff.to_csv)
      end

    puts 'You have successfully changed your Password!'
    Validation.return_to_menu("Main")
    Main.run
  end

  def self.update_existing(staffid)
    name_or_password = ' '

    while name_or_password == ' ' || name_or_password != 'N' && name_or_password != 'P'
      puts "What would you like to update?\n(Please type either N(for Name) or P(for Password)" 
      name_or_password = UserInput.entry.upcase
      if name_or_password == 'N'
        update_name(staffid)
      elsif name_or_password == 'P'
        update_password(staffid)
      else
        system 'clear'
        puts "Invalid entry, please try again."
      end
    end
  end

  def self.add_to_staff_csv(file, staff)
    CSV.open(file, 'a') do |csv|
      csv << [staff.id, staff.name, staff.role, staff.password]
    end
  end
end