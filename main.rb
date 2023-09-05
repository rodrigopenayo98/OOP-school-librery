require_relative 'person'
require_relative 'student'
require_relative 'teacher'

person = Person.new(age: 20, name: 'John Doe', parent_permission: false)
puts "Person ID: #{person.id}"
puts "Can use services? #{person.can_use_services?}"

student = Student.new('Alice', 16, true, 'Class A')
puts "Student ID: #{student.id}"
puts "Can use services? #{student.can_use_services?}"
puts "Play hooky: #{student.play_hooky}"

teacher = Teacher.new(35, 'Mr. Smith', 'Mathematics')
puts "Teacher ID: #{teacher.id}"
puts "Can use services? #{teacher.can_use_services?}"
