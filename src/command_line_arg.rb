require 'rainbow'

# CLI ARGUMENTS
module CommandLineArg
  def self.help
    system 'clear'
    puts Rainbow('Welcome to the Teams Leave App, where you can book and delete your leave').underline.yellow.bright
    puts " \n- Please type #{Rainbow('./run_teams_leave_app.sh').aqua.bright} to start booking leave."
    puts "- For more information on the what you can access in this app, please type #{Rainbow('ruby main.rb -i').aqua.bright}"
    puts "- For more information on the Ruby Gems used in this app, please type #{Rainbow('ruby main.rb -g').aqua.bright}\n "
  end

  def self.info
    system 'clear'
    puts Rainbow('Welcome to the Teams Leave App Information!').underline.yellow.bright
    puts " \n- You need your Staff ID and Password handy for logging in."
    puts '- You will need to login for managing(view/update/delete) Leave, Name and Password'
    puts " \nYour #{Rainbow('Staff ID').aqua.bright} is your name, without any space, plus the number 1"
    puts "(e.g. John Smith = #{Rainbow('Johnsmith1').aqua.bright})"
    puts "\n- You can view what dates you have already requested."
    puts '- You can view your remaining leave credits (depending on your role).'
    puts " \n#{Rainbow('When you submit a leave request, the app will automatically check:').underline}"
    puts '     1. If you have already booked a particular date'
    puts '     2. If you are unable to request leave due to work requirements'
    puts " \n- You can delete a leave that you previously requested."
    puts '- You can delete your profile after safely logging in'
    puts " \n- You can create a new profile (if you are a new staff member)."
    puts "- You can update your Name or Password after safely logging in.\n "
  end

  def self.ruby_gems
    system 'clear'
    puts Rainbow("Ruby Gems Info!\n ").underline.yellow.bright
    puts "Here are the Ruby Gems used for this app:\n "
    puts '1. rainbow'
    puts '2. terminal-basic-menu'
    puts '3. tty-box'
    puts "4. tty-font\n "
  end
end
