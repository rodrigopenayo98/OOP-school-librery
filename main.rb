require_relative 'nameable'
require_relative 'decorator'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'

require_relative 'person'
require_relative 'student'
require_relative 'teacher'

person = Person.new(age: 20, name: 'John Doe', parent_permission: false)
puts "Original Name: #{person.correct_name}"

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts "Capitalized and Trimmed Name: #{capitalized_trimmed_person.correct_name}"

capitalized_person = CapitalizeDecorator.new(person)
puts "Capitalized Name: #{capitalized_person.correct_name}"

student = Student.new('Alice', 16, true, 'Class A')
puts "Student ID: #{student.id}"
puts "Can use services? #{student.can_use_services?}"
puts "Play hooky: #{student.play_hooky}"

teacher = Teacher.new(35, 'Mr. Smith', 'Mathematics')
puts "Teacher ID: #{teacher.id}"
puts "Can use services? #{teacher.can_use_services?}"
