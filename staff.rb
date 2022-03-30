require 'csv'

class Staff
  attr_reader :id, :name, :role, :password

  def initialize(id, name, role, password)
    @id = id
    @name = name
    @role = role
    @password = password
  end

  # WRITE METHOD FOR UPDATE NAME
  # WRITE A METHOD FOR DELETE NAME
  def self.input_name
    puts 'Please enter your name:'
    gets.chomp.capitalize
  end

  # WRITE A METHOD FOR DELETE STAFF ID (WHEN I DELETE A STAFF OFF THE CSV FILE)
  def self.create_id(new_staff_name)
    "#{new_staff_name.gsub(/[[:space:]]/, '')}1"
  end

  def self.input_role
    puts "Please enter your role: \n (Please enter either MANAGER or TEAM_MEMBER)"
    gets.chomp.upcase
  end

  # CREATE METHOD FOR UPDATE PASSWORD (DELETING OF PASSWORD HANDLED BY DELETE STAFF)
  def self.input_password
    puts 'Please enter a password:'
    gets.chomp
  end

  # CREATE NEW METHOD FOR UPDATE AND DELETE EXISTING STAFF DETAILS 
  def self.create_new
    new_staff_name = input_name
    new_staff_id = create_id(new_staff_name)
    new_staff_role = input_role
    new_staff_password = input_password
    Staff.new(new_staff_id, new_staff_name, new_staff_role, new_staff_password)
  end

  # CREATE METHOD FOR UPDATING AND DELETING EXISTING STAFF DEATILS FROM CSV
  def self.add_to_staff_csv(newbie)
    CSV.open('staff.csv', 'a') do |csv|
      csv << [newbie.id, newbie.name, newbie.role, newbie.password]
      puts 'completed'
    end
  end

end