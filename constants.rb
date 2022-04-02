require 'csv'
require 'json'

module Constants
  MANAGER_MAX_LEAVE_ALLOCATED = 30
  TEAM_MEMBER_MAX_LEAVE_ALLOCATED = 20

  READ_STAFF_FILE = CSV.read('staff.csv')
  EDIT_STAFF_FILE = CSV.table('staff.csv')
  READ_DATES_FILE = JSON.load_file('dates.json')

  READ_STAFF_OUTPUT_FILE = CSV.read('staff_output.csv')
end