require_relative 'staff'
require_relative 'user_input'
require_relative 'menu'
require_relative 'leave'
require_relative 'validation'

class Main
  def self.run
      Menu.main_greeting
      menu_selection = UserInput.entry_main
      Menu.make_selection(menu_selection)
  end

  Main.run
end