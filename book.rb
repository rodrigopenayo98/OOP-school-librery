class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    @book_id = rand(1..1000)
  end

  def id
    @book_id
  end

  def add_rental(rental)
    rentals << rental
  end

  # to data project --------------------------
  def to_json(_options = {})
    {
      title: @title,
      author: @author,
      "book.id": @book_id
    }.to_json
  end
  # to data project --------------------------
end

