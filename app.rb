require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'
require_relative 'json_persistence'
require 'json'


class App
  include JsonPersistence

  def initialize
    @loaded_data = false
    @books = []
    @people = []
    load_data_if_needed 
    @rentals = []
  end

  def load_data_if_needed
    unless @loaded_data
      load_people_from_json
      load_books_from_json
      load_rentals_from_json
      @loaded_data = true
    end
  end

  #------------- creations

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
    gets.chomp.downcase
    person = Student.new(name, age)
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
    person = Teacher.new(name: name, age: age, specialization: specialization)
    @people.push(person)
    puts "Teacher '#{name}' created successfully"
    save_people_to_json
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts "Book '#{title}' created successfully with ID: #{book.id}"
    save_books_to_json
  end

  def create_rental
    puts 'Selecciona un libro de la siguiente lista por número'
    list_books
    selected_book = gets.chomp.to_i - 1
  
    puts 'Selecciona una persona de la siguiente lista por número (no por id)'
    list_people
    selected_person = gets.chomp.to_i - 1
  
    date = ''
    while date.empty?
      print 'Fecha: '
      date = gets.chomp
    end
  
    load_rentals_from_json
  
    book = @books[selected_book]
    person = @people[selected_person]
    
    person_id = person.id
    book_id = book.id
  
    rental = Rental.new(date, book.title, person, person_id, book_id)
  
    @rentals.push(rental)
    
    save_rentals_to_json
  
    puts "Alquiler creado con éxito"
  end
  
   
  

  #------------- lists

  def list_books
    puts 'List of Books:'
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, index|
      if person.instance_of?(Student)
        type = 'Student'
      elsif person.instance_of?(Teacher)
        type = 'Teacher'
      end

      puts "#{index + 1} - [#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  # def list_rentals
  #   puts 'ID of person: '
  #   person_id = gets.chomp.to_i
  #   found_rentals = @rentals.select { |rental| rental.person.id == person_id }
  
  #   if found_rentals.empty?
  #     puts "There are no rentals for the person with ID #{person_id}"
  #   else
  #     puts 'Rentals:'
  #     found_rentals.each do |rental|
  #       puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
  #     end
  #   end
  # end
  
  #------------- load date

  def load_books_from_json
    if File.exist?('books.json')
      books_json = File.read('books.json')
      books_data = JSON.parse(books_json)
  
      @books = books_data.map do |book_data|
        Book.new(book_data['title'], book_data['author'])
      end
  
      puts '----- Books loaded successfully -----'
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}, ID: #{book.id}"
      end
    else
      puts 'No book data found in books.json'
    end
  end
  
  
  def load_people_from_json
    people_json = File.read('people.json')
    people_data = JSON.parse(people_json)
  
    @people = people_data.map do |person_data|
      if person_data['type'] == 'student'
        Student.new(person_data['name'], person_data['age'], person_data['parent_permission'], person_data['id'])
      else
        Teacher.new(name: person_data['name'],age: person_data['age'], specialization: person_data['specialization'])
      end
    end
  
    puts '----- People loaded successfully -----'
    @people.each do |person|
      type = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "[#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end
  

  

  def load_rentals_from_json
    if File.exist?('rentals.json')
      rentals_json = File.read('rentals.json')
      rentals_data = JSON.parse(rentals_json)
      puts '----- Rentals loaded successfully -----'
      rentals_data.each do |rental_data|
        date = rental_data['date']
        title = rental_data['title']
        person_id = rental_data['person_id']
        book_id = rental_data['book_id']
        person = @people.find { |p| p.id == person_id }
        book = @books.find { |b| b.id == book_id }
    
        puts "Person Name: #{person.name}, Date: #{date}, Book Title: #{title}"
      end
    else
      puts 'No rental data found in rentals.json'
    end
  end
  
  

  #------------- save date

  def save_people_to_json
    people_data = @people.map do |person|
      if person.is_a?(Student)
        {
          id: person.id,
          name: person.name,
          age: person.age,
          parent_permission: person.parent_permission,
          classroom: person.classroom
        }
      elsif person.is_a?(Teacher)
        {
          id: person.id,
          name: person.name,
          age: person.age,
          specialization: person.specialization
        }
      end
    end
    File.open('people.json', 'w') do |file|
      file.puts people_data.to_json
    end
  rescue JSON::GeneratorError => e
    puts "Error al generar JSON: #{e.message}"
  rescue StandardError => e
    puts "Error desconocido al guardar datos en JSON: #{e.message}"
  end

  def save_books_to_json
    File.open('books.json', 'w') do |file|
      books_json = @books.map do |book|
        {
          "book.id": book.id,
          title: book.title,
          author: book.author
        }
      end
      file.puts books_json.to_json
    end
  rescue JSON::GeneratorError => e
    puts "Error al generar JSON de libros: #{e.message}"
  rescue StandardError => e
    puts "Error desconocido al guardar datos en JSON de libros: #{e.message}"
  end
  

  def save_rentals_to_json
    File.open('rentals.json', 'w') do |file|
      rentals_data = @rentals.map do |rental|
        {
          date: rental.date,
          title: rental.title,
          person: rental.person.name,
          person_id: rental.person_id,
          book_id: rental.book_id
        }
      end
      file.puts rentals_data.to_json
    end
  rescue JSON::GeneratorError => e
    puts "Error al generar JSON de alquileres: #{e.message}"
  rescue StandardError => e
    puts "Error desconocido al guardar datos en JSON de alquileres: #{e.message}"
  end
  
  #------------- display menu

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      process_choice(choice)
      break if choice == 7
    end
  end
  

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
      puts 'Thank you for using App.'
    end
  end
end
