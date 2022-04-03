require_relative 'staff'
require_relative 'user_input'
require_relative 'menu'
require_relative 'leave'
require_relative 'validation'
require_relative 'command_line_arg'

class Main
  include CommandLineArg

  def self.run
    Menu.main_greeting
    menu_selection = UserInput.entry_main
    Menu.make_selection(menu_selection)
  end

  def self.arg_menu
    run if ARGV.length.zero?
    case ARGV[0]
    when '-h'
      CommandLineArg.help
    when '-i'
      CommandLineArg.info
    when '-g'
      CommandLineArg.ruby_gems
    end

  end
  # run
  arg_menu
end