class Menu

  def self.login
    puts "Please enter Staff ID and Password:"
  end

  def self.exit
    puts "You have logged out of Team Leave App!"
  end

  def self.menu_greeting
    puts " \nWelcome to the Team Leave App! \n "
    puts "Please enter a number or 'H' or 'Q' to select from the following:"
    puts '1. Login'
    puts '2. Create new profile'
    puts '3. Update Existing profile/password'
    puts '4. Delete Existing profile'
    puts 'H. Help menu'
    puts "Q. Exit \n "
  end

  def self.options
    menu_selection = ' '
    while menu_selection != '1' && menu_selection != '2' && menu_selection != '3' && menu_selection !='4' && menu_selection != 'H' && menu_selection != 'Q'
      menu_greeting
      menu_selection = UserInput.entry.upcase
      case menu_selection
      when "1"
        login
      when "2"
        enter_new_staff = Staff.create_new
        Staff.add_to_staff_csv(enter_new_staff)
      when "3"
        p "# PULL FROM STAFF CLASS"
      when "4"
        p "# PULL FROM STAFF CLASS"
      when "H"
        p "# PULL FROM HELP METHOD/CLASS"
      when "Q"
        exit
      else 
        puts "You have entered an invalid choice"
      end
    end
  end

end