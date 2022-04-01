require_relative 'validation.rb'

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
    Staff.add_to_staff_csv(enter_new_staff)
  end

  def self.delete_profile
    staffid = Validation.login
    puts " \nAre you sure you want to delete your profile? \n (Please enter Y (for Yes) or N (for No)"
      if UserInput.entry.upcase == "Y"
        Staff.delete_existing(staffid)
      elsif UserInput.entry.upcase == "N"
        puts "No deletion"
      else
        puts "Invalid entry, please try again."
      end
    
  end

  def self.invalid_response(menu_selection)
    menu_selection != '1' && menu_selection != '2' && menu_selection != '3' && menu_selection !='4' && menu_selection != 'H' && menu_selection != 'Q'
  end

  def self.make_selection(menu_selection)
    case menu_selection
    when "1"
      staffid = Validation.login
      Leave.run(staffid)
    when "2"
      create_new_profile
    when "3"
      # PULL FROM STAFF CLASS"
    when "4"
      delete_profile
    when "H"
      # PULL FROM HELP METHOD/CLASS"
    when "Q"
      exit
    else 
      puts "You have entered an invalid choice"
    end
  end

end