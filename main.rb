require_relative 'staff.rb'
require_relative 'user_input.rb'
require_relative 'menu.rb'

class Main

  def self.run
    menu_selection = ' '
    while Menu.invalid_response(menu_selection)
      Menu.menu_greeting
      menu_selection = UserInput.entry.upcase
      Menu.make_selection(menu_selection)
    end
  end

Main.run
end