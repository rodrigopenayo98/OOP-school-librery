class Teacher < Person
  attr_accessor :specialization

  def initialize(name, age, specialization = 'Unknown')
    super( name: name, age: age, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
