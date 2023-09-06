require_relative 'nameable'
require_relative 'decorator'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'

require_relative 'person'
require_relative 'student'
require_relative 'teacher'

require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

person = Person.new(name: 'John Doe', age: 20, parent_permission: false)
puts "Original Name: #{person.correct_name}"

capitalized_person = CapitalizeDecorator.new(person)
puts "Capitalized Name: #{capitalized_person.correct_name}"

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts "Capitalized and Trimmed Name: #{capitalized_trimmed_person.correct_name}"

# Crear una instancia de Classroom
classroom = Classroom.new('Class A')

# Crear una instancia de Book
book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')

# Crear una instancia de Rental para relacionar Person y Book
Rental.new('2023-09-04', book, person)

# Agregar el estudiante a la aula
classroom.add_student(person)

# Probar las relaciones y clases
puts "Classroom Label: #{classroom.label}"
puts "Classroom Students: #{classroom.students.map(&:name).join(', ')}"
puts "Book Title: #{book.title}, Author: #{book.author}"
puts "Book Rentals: #{book.rentals.map(&:date).join(', ')}"
puts "Person Name: #{person.name}, Age: #{person.age}"
puts "Person Rentals: #{person.rentals.map(&:date).join(', ')}"
