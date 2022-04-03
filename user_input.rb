require_relative 'constants'

# USER INPUT CLASS FOR ALL FEATURES
class UserInput
  include Constants
  def self.entry
    begin
      input = gets.chomp
      raise(StandardError, MUST_NOT_BE_EMPTY_ERROR_MESSAGE) if input.empty?
      raise(StandardError, MUST_NOT_BE_EMPTY_ERROR_MESSAGE) if input.strip == ''
    rescue StandardError => e
      puts e.message
      retry
    end
    input
  end

  def self.entry_main
    begin
      input = gets.chomp.upcase
      raise(StandardError, MUST_NOT_BE_EMPTY_ERROR_MESSAGE) if input.empty?
      raise(StandardError, MUST_NOT_BE_EMPTY_ERROR_MESSAGE) if input.strip == ''
      raise(StandardError, INVALID_INPUT_ERROR_MESSAGE) if Menu.invalid_response(input)
    rescue StandardError => e
      puts e.message
      retry
    end
    input
  end

  def self.entry_leave
    begin
      input = gets.chomp.upcase
      raise(StandardError, MUST_NOT_BE_EMPTY_ERROR_MESSAGE) if input.empty?
      raise(StandardError, MUST_NOT_BE_EMPTY_ERROR_MESSAGE) if input.strip == ''
      raise(StandardError, INVALID_INPUT_ERROR_MESSAGE) if Leave.invalid_leave_response(input)
    rescue StandardError => e
      puts e.message
      retry
    end
    input
  end

  def self.enterkey_entry
    gets.chomp
  end
end
