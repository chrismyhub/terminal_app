class Staff
  attr_reader :id, :name, :role, :password

  def initialize(id, name, role, password)
    @id = id
    @name = name
    @role = role
    @password = password
  end

end