require_relative 'constants'
require_relative 'staff'
require_relative 'validation'
require 'tty-box'
require 'table_print'

class Leave
  attr_reader :staffid, :leave_days_by_role, :leave_taken, :leave_remaining

  include Constants

  def initialize(staffid, leave_days_by_role, leave_taken, leave_remaining)
    @staffid = staffid
    @leave_days_by_role = leave_days_by_role
    @leave_taken = leave_taken
    @leave_remaining = leave_remaining
  end

  def self.retreive_staff_name(staffid)
    READ_STAFF_FILE.find { |name| name.include?(staffid)}[1]
  end

  def self.menu(staffid)
    header_text = "Welcome #{retreive_staff_name(staffid)}!"
    header = { text: header_text, color: :yellow }
    body_text = "Please enter a number or 'H' or 'Q' to select from the following:"
    body_choices = ['Request New Leave', 'Delete Existing Leave']
    body = {text: body_text, choices: body_choices, align: 'center', color: :white }
    footer_text = "H. Help Menu\nM. Return to Main Menu\nQ. Exit"
    footer = { text: footer_text, align: 'rjust', color: :orange }
    menu1 = Menu.new(header: header, body: body, footer: footer)
    menu1.border_color = :lightyellow
    system('clear')
    menu1.display_menu

    puts "#{Rainbow('Your current requested dates are:').pink.bright}"
    if retrieve_dates_taken(staffid).empty?
      print ''
    else
      box = TTY::Box.frame "#{retrieve_dates_taken(staffid).join(', ')}", padding: 1, align: :center,
          style:{ fg: :white, bg: :green, border:{ fg: :black, bg: :green } }
      print box
    end
    puts " "
    displaying_remaining_leave_credits(staffid)

  end

  def self.max_allocated_days(staffid)
    if Staff.find_staff_in_csv(staffid, 2) == 'MANAGER_MAX_LEAVE_ALLOCATED'
      leave_days_by_role = MANAGER_MAX_LEAVE_ALLOCATED
    else 
      leave_days_by_role = TEAM_MEMBER_MAX_LEAVE_ALLOCATED
    end
    leave_days_by_role
  end

  def self.is_date_already_booked(leave_date, staffid)
    READ_DATES_FILE[0][leave_date].any? { |s| s.include?(staffid) }
  end

  def self.is_max_capacity_reached(leave_date)
    (READ_DATES_FILE[0][leave_date].length >= 2) 
  end

  def self.updating_new_leave_to_dates_file(leave_date, staffid)
    READ_DATES_FILE[0][leave_date] << staffid
    File.write('dates.json', JSON.pretty_generate(READ_DATES_FILE))
    puts "Your leave request for #{leave_date}, is confirmed!"
  end

  def self.retrieve_dates_taken(staffid)
    READ_DATES_FILE[0].select { |date, names| names.include? (staffid) }.keys
  end

  def self.displaying_remaining_leave_credits(staffid)
    dates_taken = retrieve_dates_taken(staffid)
    number_of_dates_taken = dates_taken.length
    leave_days_by_role = max_allocated_days(staffid)
    remaining_leave = leave_days_by_role - number_of_dates_taken
    if number_of_dates_taken == 0
      box = TTY::Box.frame "YOU CURRENTLY HAVE NO REQUESTED LEAVE", padding: 1, align: :center,
        style:{ fg: :bright_yellow, bg: :blue, border:{ fg: :bright_yellow, bg: :blue } }
      print box
      puts "Your #{Rainbow('remaining').underline.pink} leave credits: #{remaining_leave} days\n "
    else
      puts "Your #{Rainbow('remaining').underline.pink} leave credits: #{remaining_leave} days\n "
    end
  end

  def self.create_new(staffid)
    leave_date = ' '

    while leave_date == ' ' || is_date_already_booked(leave_date, staffid) || is_max_capacity_reached(leave_date)
      puts "\n Please enter leave date required:\n(in the format DDMMMYY)"
      leave_date = UserInput.entry.upcase
      system 'clear'
      if is_date_already_booked(leave_date, staffid)
        puts " \nYou have already booked this date, please try another date.\n "
      elsif is_max_capacity_reached(leave_date)
        puts " \nUnable to book, maximum capacity reached.  Please try another date.\n "
      else
        updating_new_leave_to_dates_file(leave_date, staffid)
        displaying_remaining_leave_credits(staffid)
        break
      end
    end
  end

  def self.delete_leave(staffid)
    puts "Please enter date to delete:\n(in the format DDMMMYY)"
    date_to_delete = UserInput.entry.upcase
    if READ_DATES_FILE[0][date_to_delete].any? { |name| name.include?(staffid) }
      READ_DATES_FILE[0][date_to_delete].delete(staffid)
      File.write('dates.json', JSON.pretty_generate(READ_DATES_FILE))
      system 'clear'
      puts "\n #{Rainbow("You have successfully deleted leave for #{date_to_delete}!").bg(:darkgreen)}\n "
    end
  end

  def self.invalid_leave_response(leave_menu_selection)
    leave_menu_selection != '1' && 
      leave_menu_selection != '2' && 
      leave_menu_selection != 'H' &&
      leave_menu_selection != 'M' && 
      leave_menu_selection != 'Q'
  end

  def self.leave_make_selection(staffid, leave_menu_selection)
    case leave_menu_selection
    when '1'
      create_new(staffid)
      Validation.return_to_menu("Leave")
      run(staffid)
    when '2'
      delete_leave(staffid)
      Validation.return_to_menu("Leave")
      run(staffid)
    when 'H'
      puts 'Help Menu'
    when 'M'
      Main.run
    when 'Q'
      Menu.exit
    else 
      puts INVALID_INPUT_ERROR_MESSAGE
    end
  end

  def self.run(staffid)
      menu(staffid)
      leave_menu_selection = UserInput.entry_leave
      leave_make_selection(staffid, leave_menu_selection)

  end
end
