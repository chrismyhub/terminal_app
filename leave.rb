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

  def self.retreive_staff_name(data_staff, staffid)
    data_staff.find { |name| name.include?(staffid)}[1]
  end

  def self.menu(data, data_staff, staffid)
    system 'clear'
    puts "STAFF LEAVE MENU\n "
    puts "Welcome #{retreive_staff_name(data_staff, staffid)}! \n "
    puts 'Your current requested dates are:'
    puts retrieve_dates_taken(data, staffid)
    puts " "
    displaying_remaining_leave_credits(data, data_staff, staffid)
    puts " \nPlease enter a number or 'H' or 'Q' to select from the following:\n "
    puts '1. Request New Leave'
    puts "2. Delete Existing Untaken Leave \n "
    puts 'H. Help Menu'
    puts 'M. Return to Main Menu'
    puts "Q. Exit \n "
  end

  def self.max_allocated_days(data, data_staff, staffid)
    if (data_staff.find { |values| values.include?(staffid)}[2]) == 'MANAGER_MAX_LEAVE_ALLOCATED'
      leave_days_by_role = MANAGER_MAX_LEAVE_ALLOCATED
    else 
      leave_days_by_role = TEAM_MEMBER_MAX_LEAVE_ALLOCATED
    end
    leave_days_by_role
  end

  def self.is_date_already_booked(data, leave_date, staffid)
    data[0][leave_date].any? { |s| s.include?(staffid) }
  end

  def self.is_max_capacity_reached(data, leave_date)
    (data[0][leave_date].length >= 2) 
  end

  def self.updating_new_leave_to_dates_file(data, leave_date, staffid)
    data[0][leave_date] << staffid
    File.write('dates.json', JSON.pretty_generate(data))
    puts "Your leave request for #{leave_date}, is confirmed!"
  end

  def self.retrieve_dates_taken(data, staffid)
    data[0].select { |date, names| names.include? (staffid) }.keys
  end

  def self.displaying_remaining_leave_credits(data, data_staff, staffid)
    dates_taken = retrieve_dates_taken(data, staffid)
    number_of_dates_taken = dates_taken.length
    leave_days_by_role = max_allocated_days(data, data_staff, staffid)
    remaining_leave = leave_days_by_role - number_of_dates_taken
    puts "Your remaining leave credits: #{remaining_leave} days\n "
  end

  def self.create_new(data, data_staff, staffid)
    leave_date = ' '

    while leave_date = ' ' || is_date_already_booked(data, leave_date, staffid) || is_max_capacity_reached(data, leave_date)
      puts "Please enter leave date required:\n(in the format DDMMMYY)"
      leave_date = UserInput.entry.upcase
      system 'clear'
      if is_date_already_booked(data, leave_date, staffid)
        puts " \nYou have already booked this date, please try another date.\n "
      elsif is_max_capacity_reached(data, leave_date)
        puts " \nUnable to book, maximum capacity reached.  Please try another date.\n "
      else
        updating_new_leave_to_dates_file(data, leave_date, staffid)
        displaying_remaining_leave_credits(data, data_staff, staffid)
        break
      end
    end
  end

  def self.delete_leave(data, data_staff, staffid)
    staff_name = retreive_staff_name(data_staff, staffid)
    puts "Hi #{staff_name}, please enter date to delete:\n(in the format DDMMMYY)"
    date_to_delete = UserInput.entry.upcase
    if data[0][date_to_delete].any? { |name| name.include?(staffid) }
      data[0][date_to_delete].delete(staffid)
      File.write('dates.json', JSON.pretty_generate(data))
      system 'clear'
      puts "You have successfully deleted leave for #{date_to_delete}!\n "
    end
  end

  def self.invalid_leave_response(leave_menu_selection)
    leave_menu_selection != '1' && 
      leave_menu_selection != '2' && 
      leave_menu_selection != 'H' && 
      leave_menu_selection != 'Q'
  end

  def self.leave_make_selection(data, data_staff, staffid)
    leave_menu_selection = UserInput.entry.upcase
        case leave_menu_selection
        when "1"
          create_new(data, data_staff, staffid)
        when "2"
          delete_leave(data, data_staff, staffid)
        when "H"

        when "Q"

        else 
          puts "You have entered an invalid choice"
        end
  end

 

  def self.run(staffid)
    data = JSON.load_file('dates.json')
    data_staff = CSV.read('staff.csv')
    leave_menu_selection = ' '
    while invalid_leave_response(leave_menu_selection)
      menu(data, data_staff, staffid)
      leave_make_selection(data, data_staff, staffid)
      break
    end
  end
end
