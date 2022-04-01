require_relative 'validation'
require_relative 'leave'

class Menu

  def self.exit
    puts "You have logged out of Team Leave App!"
  end

  def self.main_greeting
    system "clear"
    puts " \nWelcome to the Team Leave App! \n "
    puts "Please enter a number or 'H' or 'Q' to select from the following:"
    puts '1. Login'
    puts '2. Create new profile'
    puts '3. Update Existing profile/password'
    puts "4. Delete Existing profile \n "
    puts 'H. Help menu'
    puts "Q. Exit \n "
  end

  def self.create_new_profile
    enter_new_staff = Staff.create_new
    Staff.add_to_staff_csv('staff.csv', enter_new_staff)
    puts "\n Your profile is now setup!\n "
  end

  def self.delete_profile
    staffid = Validation.login
    user_input = ' '
    while user_input == ' ' || user_input != "Y" && user_input != "N"
      puts " \nAre you sure you want to delete your profile? \n (Please enter Y (for Yes) or N (for No)"
      user_input = UserInput.entry.upcase
        if user_input == "Y"
          Staff.delete_existing(staffid)
        elsif user_input == "N"
          # LINK BACK TO MAIN MENU
          puts " \nNo deletion - BACK TO MAIN MENU\n "
        else
          system 'clear'
          puts "Invalid entry, please try again."
        end
    end
  end

  def self.invalid_response(menu_selection)
    menu_selection == ' ' || menu_selection != '1' && menu_selection != '2' && menu_selection != '3' && menu_selection !='4' && menu_selection != 'H' && menu_selection != 'Q'
  end

  def self.make_selection(menu_selection)
    case menu_selection
    when "1"
      staffid = Validation.login
      Leave.run(staffid)
    when "2"
      create_new_profile
    when "3"
      staffid = Validation.login
      Staff.update_existing(staffid)
    when "4"
      delete_profile
    when "H"
      puts "Go to Help Menu"
    when "Q"
      puts "You have exited!"
    else 
      puts "You have entered an invalid choice"
    end
  end

end