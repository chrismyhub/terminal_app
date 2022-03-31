require_relative 'constants.rb'
require 'csv'
require 'json'

class Leave
  attr_reader :staffid, :leave_days_by_role, :leave_taken, :leave_remaining

  include Constants

  def initialize(staffid, leave_days_by_role, leave_taken, leave_remaining)
    @staffid = staffid
    @leave_days_by_role = leave_days_by_role
    @leave_taken = leave_taken
    @leave_remaining = leave_remaining
  end

  def self.menu
    system "clear"
    puts " \n STAFF LEAVE MENU \n "
    # puts " \nWelcome STAFF NAME, you have taken #{leave_taken}"
    # puts "your current leave credits are #{leave_remaining}"
    puts 'Your current requested dates are:'
    # puts  ENTER METHOD FOR DISPLAYING CURRENT REQUESTED DATES
    puts "Leave Options Menu \n "
    puts "Please enter a number or 'H' or 'Q' to select from the following:"
    puts '1. Request New Leave'
    puts "2. Delete Existing Untaken Leave \n "
    puts 'H. Help Menu'
    puts 'M. Return to Main Menu'
    puts "Q. Exit \n "
  end

  def self.max_allocated_days(staffid)
    data = JSON.load_file('dates.json')
    data_staff = CSV.read('staff.csv')

    if (data_staff.find { |values| values.include?(staffid)}[2]) == 'MANAGER_MAX_LEAVE_ALLOCATED'
      leave_days_by_role = MANAGER_MAX_LEAVE_ALLOCATED
    else 
      leave_days_by_role = TEAM_MEMBER_MAX_LEAVE_ALLOCATED
    end
    leave_days_by_role
  end

#   def self.date_already_booked(staffid, leave_date)
#     data = JSON.load_file('dates.json')
#     data[0][leave_date].any? { |s| s.include?(staffid) }
#   end

#   def self.insufficient_staff_on_date(data, leave_date)
#     (data[0][leave_date].length >= 2)
#   end

#   def self.create_new(staffid)
#     data = JSON.load_file('dates.json')
#     data_staff = CSV.read('staff.csv')
#     leave_date = ' '

#     while data[0][leave_date].any? { |s| s.include?(staffid) } || insufficient_staff_on_date(data, leave_date)
#       system "clear"
#       puts "Please enter leave date required:\n(in the format DDMMMYY)"
#       leave_date = UserInput.entry.upcase

#       if data[0][leave_date].any? { |s| s.include?(staffid) }
#         puts 'You have already booked this date, please try another date.'
#       elsif insufficient_staff_on_date(data, leave_date)
#         puts 'Unable to book, maximum capacity reached.  Please try another date.'
#       else
#         data[0][leave_date] << staffid
#         File.write('dates.json', JSON.pretty_generate(data))
#           puts "Your leave request for #{leave_date}, is confirmed!"
    
#         dates_taken =  data[0].select { |date, names| names.include? (staffid) }.keys
#         number_of_dates_taken = dates_taken.length
#         leave_days_by_role = max_allocated_days(staffid)
#         remaining_leave = leave_days_by_role - number_of_dates_taken
#          puts "Your remaining leave credits: #{remaining_leave} days"
#       end
#     end
#   end

# def self.create_new(staffid)
#     data = JSON.load_file('dates.json')
#     data_staff = CSV.read('staff.csv')
#     leave_date = ' '
#     # IN DIFF PLACES CREATES NEW ISSUES
#     system "clear"
#     while leave_date = ' ' || data[0][leave_date].any? { |s| s.include?(staffid) } || (data[0][leave_date].length >= 2)
#     puts "Please enter leave date required:\n(in the format DDMMMYY)"
#     leave_date = UserInput.entry.upcase
    
#     if data[0][leave_date].any? { |s| s.include?(staffid) }
#       puts 'You have already booked this date, please try another date.'
#     elsif (data[0][leave_date].length >= 2)  
#       puts 'Unable to book, maximum capacity reached.  Please try another date.'
#     else
#       data[0][leave_date] << staffid
#       File.write('dates.json', JSON.pretty_generate(data))
#         puts "Your leave request for #{leave_date}, is confirmed!"
    
#       dates_taken =  data[0].select { |date, names| names.include? (staffid) }.keys
#       number_of_dates_taken = dates_taken.length
#       leave_days_by_role = max_allocated_days(staffid)
#       remaining_leave = leave_days_by_role - number_of_dates_taken
#        puts "Your remaining leave credits: #{remaining_leave} days"
#     end
#     end
#   end



def self.create_new(staffid)
    data = JSON.load_file('dates.json')
    data_staff = CSV.read('staff.csv')

    
    puts "Please enter leave date required:\n(in the format DDMMMYY)"
    leave_date = UserInput.entry.upcase

    if data[0][leave_date].any? { |s| s.include?(staffid) }
      puts 'You have already booked this date, please try another date.'
    elsif (data[0][leave_date].length >= 2)  
      puts 'Unable to book, maximum capacity reached.  Please try another date.'
    else
      data[0][leave_date] << staffid
      File.write('dates.json', JSON.pretty_generate(data))
        puts "Your leave request for #{leave_date}, is confirmed!"
    
      dates_taken =  data[0].select { |date, names| names.include? (staffid) }.keys
      number_of_dates_taken = dates_taken.length
      leave_days_by_role = max_allocated_days(staffid)
      remaining_leave = leave_days_by_role - number_of_dates_taken
       puts "Your remaining leave credits: #{remaining_leave} days"
    end

  end
  def self.run(staffid)
    menu
    create_new(staffid)
  end
end


# def self.create_new(staffid)
#     data = JSON.load_file('dates.json')
#     data_staff = CSV.read('staff.csv')

#     system "clear"
#     puts "Please enter leave date required:\n(in the format DDMMMYY)"
#     leave_date = UserInput.entry.upcase

#     if data[0][leave_date].any? { |s| s.include?(staffid) }
#       puts 'You have already booked this date, please try another date.'
#     elsif (data[0][leave_date].length >= 2)  
#       puts 'Unable to book, maximum capacity reached.  Please try another date.'
#     else
#       data[0][leave_date] << staffid
#       File.write('dates.json', JSON.pretty_generate(data))
#         puts "Your leave request for #{leave_date}, is confirmed!"
    
#       dates_taken =  data[0].select { |date, names| names.include? (staffid) }.keys
#       number_of_dates_taken = dates_taken.length
#       leave_days_by_role = max_allocated_days(staffid)
#       remaining_leave = leave_days_by_role - number_of_dates_taken
#        puts "Your remaining leave credits: #{remaining_leave} days"
#     end

#   end