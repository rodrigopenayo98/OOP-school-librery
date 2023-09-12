require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'
require 'json'

class App
  @@loaded_data = false
  def initialize
    @books = []
    @people = []
    @rentals = []
    load_people_from_json if File.exist?('people.json')
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp.to_i
    case type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid input. Please enter 1 for a student or 2 for a teacher.'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission_input = gets.chomp.downcase
    parent_permission = parent_permission_input == 'y'
    person = Student.new(name, age, parent_permission)
    @people.push(person)
    puts "Student '#{name}' created successfully"
    save_people_to_json
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name: name)
    @people.push(person)
    puts "Teacher '#{name}' created successfully"
    save_people_to_json
  end

  # Modify the create_book method in app.rb
  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts "Book '#{title}' created successfully"
    save_books_to_json # Save the updated book list to books.json
  end

  # Add or modify the following methods in app.rb to save and load books from books.json
  def save_books_to_json
    File.open('books.json', 'w') do |file|
      file.puts @books.map(&:to_json).to_json
    end
  end

  def load_books_from_json
    @books = if File.exist?('books.json')
               JSON.parse(File.read('books.json')).map do |book_data|
                 Book.new(book_data['title'], book_data['author'])
               end
             else
               []
             end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index}) [#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    @rentals.push(Rental.new(date, @books[book_index], @people[person_index]))
    puts 'Rental created successfully'
    save_rentals_to_json
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "#{index} - Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, index|
      type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index} - [#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_rentals
    if @rentals.empty?
      puts 'There are no rentals to show'
    else
      puts 'ID of person: '
      person_id = gets.chomp.to_i
      puts 'Rentals: '
      @rentals.each do |rental|
        if person_id == rental.person.id
          puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
        end
      end
    end
  end

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      process_choice(choice)
      break if choice == 7
    end
  end

  def save_people_to_json
    File.open('people.json', 'w') do |file|
      file.puts @people.to_json
    end
  rescue JSON::GeneratorError => e
    puts "Error al generar JSON: #{e.message}"
  rescue StandardError => e
    puts "Error desconocido al guardar datos en JSON: #{e.message}"
  end

  def load_people_from_json
    if File.exist?('people.json')
      begin
        @people = JSON.parse(File.read('people.json')).map do |person_data|
          if person_data.is_a?(Hash) && person_data.key?('type')
            if person_data['type'] == 'Student'
              Student.new(person_data['name'], person_data['age'], person_data['parent_permission'])
            elsif person_data['type'] == 'Teacher'
              Teacher.new(person_data['name'], person_data['age'], person_data['specialization'])
            end
          else
            puts 'Error: At the moment the people JSON file is empty.'
            nil
          end
        end.compact # Eliminar elementos nulos si los hay
      rescue JSON::ParserError => e
        puts "Error al analizar el archivo JSON: #{e.message}"
        @people = []
      end
    else
      @people = []
    end
  end
  # def save_rentals_to_json
  #   File.open('rentals.json', 'w') do |file|
  #     file.puts @rentals.to_json
  #   end
  # end

  # def load_rentals_from_json
  #   if File.exist?('rentals.json')
  #     @rentals = JSON.parse(File.read('rentals.json')).map do |rental_data|
  #       book = @books.find { |book| book.title == rental_data['book']['title'] }
  #       person = @people.find { |person| person.id == rental_data['person']['id'] }
  #       Rental.new(rental_data['date'], book, person)
  #     end
  #   else
  #     @rentals = []
  #   end
  # end

  # to data project --------------------------

  private

  def display_menu
    puts 'Choose an option:'
    puts '1. Create a person'
    puts '2. Create a book'
    puts '3. Create a rental'
    puts '4. List all books'
    puts '5. List all people'
    puts '6. List rentals for a person'
    puts '7. Quit'
  end

  def process_choice(choice)
    case choice
    when 1
      create_person
    when 2
      create_book
    when 3
      create_rental
    when 4
      list_books
    when 5
      list_people
    when 6
      list_rentals
    else
      puts 'Invalid option. Please choose a valid option.'
    end
  end
end
