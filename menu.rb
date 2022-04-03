require_relative 'validation'
require_relative 'leave'
require 'terminal-basic-menu'
require 'rainbow'
require 'tty-font'
require_relative 'staff'

class Menu
  def self.exit
    puts " \nYou have logged out of Team Leave App, Goodbye!\n "
  end

  def self.main_greeting
    header_text = "WELCOME TO THE TEAM LEAVE APP!"
    header = { text: header_text, color: :ghostwhite }
    body_text = "Please enter a number or 'H' or 'Q' to select from the following:"
    body_choices = ['Login', 'Create new profile', 'Update Existing profile/password', 'Delete Existing profile']
    body = {text: body_text, choices: body_choices, align: 'center', color: :white }
    footer_text = "H. Help Menu\nQ. Exit"
    footer = { text: footer_text, align: 'rjust', color: :orange }
    menu1 = Menu.new(header: header, body: body, footer: footer)
    menu1.border_color = :lightyellow
    system('clear')
    font = TTY::Font.new(:straight)
    puts font.write("TEAM    LEAVE    APP")
    menu1.display_menu
    
  end

  def self.create_new_profile
    enter_new_staff = Staff.create_new
    Staff.add_to_staff_csv('staff.csv', enter_new_staff)
    puts "\n #{Rainbow("Your profile is now setup!").bg(:darkgreen)}\n "
    Validation.return_to_menu('Main')
    system('ruby main.rb')
  end

  def self.delete_profile
    staffid = Validation.login
    user_input = ' '
    while user_input == ' ' || user_input != 'Y' && user_input != 'N'
      puts " \nAre you sure you want to delete your profile? \n (Please enter Y (for Yes) or N (for No)"
      user_input = UserInput.entry.upcase
        if user_input == "Y"
          Staff.delete_existing(staffid)
        elsif user_input == "N"
          system('ruby main.rb')
        else
          system 'clear'
          puts 'Invalid entry, please try again.'
        end
    end
  end

  def self.invalid_response(menu_selection)
    menu_selection == ' ' || menu_selection != '1' && menu_selection != '2' && menu_selection != '3' && menu_selection !='4' && menu_selection != 'H' && menu_selection != 'Q'
  end


  def self.make_selection(valid_input)
    case valid_input
    when '1'
      staffid = Validation.login
      Leave.run(staffid)
    when '2'
      create_new_profile
    when '3'
      staffid = Validation.login
      Staff.update_existing(staffid)
    when '4'
      delete_profile
    when 'H'
      puts 'Go to Help Menu'
    when 'Q'
      exit
    else 
      puts 'Invalid selection, please try again'
    end
  end

end