class Teacher < Person
  attr_accessor :specialization

  def initialize(name:, age:, specialization: 'Unknown', parent_permission: true, id:)
    super(name: name, age: age, parent_permission: parent_permission, id: id)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end


