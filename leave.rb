class Leave
  attr_reader :staffid

  def initialize(staffid, role, leave_taken, leave_remaining)
    @staffid = staffid
    @role = role
    @leave_taken = leave_taken
    @leave_remaining = leave_remaining
  end
end