require_relative 'constants.rb'
require 'csv'
require 'json'

class Leave
  attr_reader :staffid, :leave_days_by_role, :leave_taken, :leave_remaining

  def initialize(staffid, leave_days_by_role, leave_taken, leave_remaining)
    @staffid = staffid
    @leave_days_by_role = leave_days_by_role
    @leave_taken = leave_taken
    @leave_remaining = leave_remaining
  end

  data = JSON.load_file('dates.json')
  data_staff = CSV.read('staff.csv')


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

  def max_allocated_days(staffid)
    if (data_staff.find { |values| values.include?(staffid)}[2]) == "MANAGER_MAX_LEAVE_ALLOCATED"
      leave_days_by_leave_days_by_role = Constants.MANAGER_MAX_LEAVE_ALLOCATED
    else 
      leave_days_by_leave_days_by_role = Constants.TEAM_MEMBER_MAX_LEAVE_ALLOCATED
    end
  end

  def create_new

  end

  def self.run
    menu
  end
end