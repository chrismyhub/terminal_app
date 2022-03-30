require_relative 'validation.rb'

class Menu

  def self.login
    is_invalid_staff = true

    while is_invalid_staff
      puts "Please enter your Staff ID:"
      staffid = UserInput.entry
      puts "Please enter your Password:"
      password = UserInput.entry
      is_invalid_staff = !(Validation.is_valid_staff(staffid, password))
        if is_invalid_staff == true 
          puts "Incorrect login details, please try again."
        else
          puts "Successful login!"
        end
    end
  end

  def self.exit
    puts "You have logged out of Team Leave App!"
  end

  def self.main_greeting
    puts " \nWelcome to the Team Leave App! \n "
    puts "Please enter a number or 'H' or 'Q' to select from the following:"
    puts '1. Login'
    puts '2. Create new profile'
    puts '3. Update Existing profile/password'
    puts '4. Delete Existing profile'
    puts 'H. Help menu'
    puts "Q. Exit \n "
  end

  def self.create_new_profile
    enter_new_staff = Staff.create_new
    Staff.add_to_staff_csv(enter_new_staff)
  end

  def self.invalid_response(menu_selection)
    menu_selection != '1' && menu_selection != '2' && menu_selection != '3' && menu_selection !='4' && menu_selection != 'H' && menu_selection != 'Q'
  end

  def self.make_selection(menu_selection)
    case menu_selection
    when "1"
      login
    when "2"
      create_new_profile
    when "3"
      # PULL FROM STAFF CLASS"
    when "4"
      # PULL FROM STAFF CLASS"
    when "H"
      # PULL FROM HELP METHOD/CLASS"
    when "Q"
      exit
    else 
      puts "You have entered an invalid choice"
    end
  end

end