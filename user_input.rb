class UserInput
  def self.entry
    begin
      input = gets.chomp
      raise(StandardError, 'Must not be empty, please try again.') if input.empty?
      raise(StandardError, 'Must not be empty, please try again.') if input.strip == ''
    rescue StandardError => e
      puts e.message
      retry
    end
    return input
  end

end