class Book
  attr_accessor :title, :author, :rentals, :id  # Corrige :id aquí

  def initialize(title, author, id: Random.rand(1...1000))
    @title = title
    @author = author
    @rentals = []
    @id = id  # Corrige @book_id a @id aquí
  end

  def add_rental(rental)
    rentals << rental
  end

  def to_json(_options = {})
    {
      title: @title,
      author: @author,
      "book.id": @id  # Corrige @book_id a @id aquí
    }.to_json
  end
end


