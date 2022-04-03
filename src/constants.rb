require 'csv'
require 'json'
require 'rainbow'

module Constants
  MANAGER_MAX_LEAVE_ALLOCATED = 30
  TEAM_MEMBER_MAX_LEAVE_ALLOCATED = 20

  READ_STAFF_FILE = CSV.read('staff.csv')
  EDIT_STAFF_FILE = CSV.table('staff.csv')
  READ_DATES_FILE = JSON.load_file('dates.json')

  MUST_NOT_BE_EMPTY_ERROR_MESSAGE = "\n #{Rainbow('Must not be empty, please try again.').bg(:darkred)}\n "
  INVALID_INPUT_ERROR_MESSAGE = "\n #{Rainbow('Invalid entry, please try again').bg(:darkred)}\n "
end
