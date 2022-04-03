module CommandLineArg
  def self.help
    system 'clear'
    puts 'Welcome to the Teams Leave App, where you can book and delete your leave.'
    puts 'Please type ./run_teams_leave_app.sh to start booking leave.'
    # puts 'For more information on the what you can access in this app, please type ./run_teams_leave_app.sh -i'
    puts 'For more information on the what you can access in this app, please type ruby main.rb -i'
    # puts 'For more information on the Ruby Gems used in this app, please type ./run_teams_leave_app.sh -g'
    puts 'For more information on the Ruby Gems used in this app, please type ruby main.rb -g'
  end

  def self.info
    system 'clear'
    puts 'You need your Staff ID and Password handy for logging in.'
    puts 'You will need to login for managing(view/update/delete) Leave, Name and Password'
    puts "\nYou can view what dates you have already requested."
    puts 'You can view your remaining leave credits (depending on your role).'
    puts " \nWhen you submit a leave request, the app will automatically check:"
    puts '1. If you have already booked a particular date'
    puts '2. If you are unable to request leave due to work requirements'
    puts " \nYou can delete a leave that you previously requested."
    puts 'ou can delete your profile after safely logging in'
    puts " \nYou can create a new profile (if you are a new staff member)."
    puts "You can update your Name or Password after safely logging in.\n "
  end

  def self.ruby_gems
    system 'clear'
    puts 'Here are the Ruby Gems used for this app:'
    puts '1. rainbow'
    puts '2. terminal-basic-menu'
    puts '3. tty-box'
    puts '4. tty-font'
  end
end