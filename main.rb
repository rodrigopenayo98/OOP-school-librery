require_relative 'person'
require_relative 'student'
require_relative 'teacher'

person = Person.new("John Doe", 20, false)
puts "Person ID: #{person.id}"
puts "Can use services? #{person.can_use_services?}"

student = Student.new("Alice", 16, true, "Class A")
puts "Student ID: #{student.id}"
puts "Can use services? #{student.can_use_services?}"
puts "Play hooky: #{student.play_hooky}"

teacher = Teacher.new("Mr. Smith", 35, "Mathematics")
puts "Teacher ID: #{teacher.id}"
puts "Can use services? #{teacher.can_use_services?}"
