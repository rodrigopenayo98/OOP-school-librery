require_relative 'app'

person = Person.new(name: 'John Doe', age: 20, parent_permission: false)
puts "Original Name: #{person.correct_name}"

capitalized_person = CapitalizeDecorator.new(person)
puts "Capitalized Name: #{capitalized_person.correct_name}"

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts "Capitalized and Trimmed Name: #{capitalized_trimmed_person.correct_name}"

classroom = Classroom.new('Class A')

book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')

Rental.new('2023-09-04', book, person)

classroom.add_student(person)

puts "Classroom Label: #{classroom.label}"
puts "Classroom Students: #{classroom.students.map(&:name).join(', ')}"
puts "Book Title: #{book.title}, Author: #{book.author}"
puts "Book Rentals: #{book.rentals.map(&:date).join(', ')}"
puts "Person Name: #{person.name}, Age: #{person.age}"
puts "Person Rentals: #{person.rentals.map(&:date).join(', ')}"
class Main
  def initialize
    @app = App.new
  end

  App.new
  def run
    @app.run
  end
end
