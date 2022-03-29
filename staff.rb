class Staff
  attr_reader :staffid

  def initialize(staffid, name, role, password)
    @staffid = staffid
  end
end