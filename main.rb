require_relative 'staff'
require_relative 'user_input'
require_relative 'menu'
require_relative 'leave'
require_relative 'validation'

class Main
  def self.run
    menu_selection = ' '
    while Menu.invalid_response(menu_selection)
      Menu.main_greeting
      menu_selection = UserInput.entry.upcase
      Menu.make_selection(menu_selection)
    end
  end

  Main.run
end