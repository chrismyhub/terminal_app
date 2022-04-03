require 'csv'
require 'json'

module Constants
  MANAGER_MAX_LEAVE_ALLOCATED = 30
  TEAM_MEMBER_MAX_LEAVE_ALLOCATED = 20

  READ_STAFF_FILE = CSV.read('staff.csv')
  EDIT_STAFF_FILE = CSV.table('staff.csv')
  READ_DATES_FILE = JSON.load_file('dates.json')

  MUST_NOT_BE_EMPTY_ERROR_MESSAGE = 'Must not be empty, please try again.'
  INVALID_INPUT_ERROR_MESSAGE = 'Invalid selection, please try again'
  INVALID_STAFFID_ERROR_MESSAGE = 'Incorrect Staff ID, please try again.'
  INVALID_PASSWORD_ERROR_MESSAGE = 'Incorrect Password, please try again.'
end