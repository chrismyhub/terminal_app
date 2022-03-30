class Leave
  attr_reader :staffid, :role, :leave_taken, :leave_remaining

  def initialize(staffid, role, leave_taken, leave_remaining)
    @staffid = staffid
    @role = role
    @leave_taken = leave_taken
    @leave_remaining = leave_remaining
  end

  def self.menu
    puts " \nWelcome STAFF NAME, you have taken #{leave_taken}"
    puts "your current leave credits are #{leave_remaining}"
    puts 'Your current requested dates are:'
    # puts  ENTER METHOD FOR DISPLAYING CURRENT REQUESTED DATES
    puts "Leave Options Menu \n "
    puts "Please enter a number or 'H' or 'Q' to select from the following:"
    puts '1. Request New Leave'
    puts '2. Delete Existing Untaken Leave'
    puts 'H. Help Menu'
    puts 'M. Return to Main Menu'
    puts "Q. Exit \n "
  end




end