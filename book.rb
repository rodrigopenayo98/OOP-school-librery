class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author, id: Random.rand(1...1000))
    @title = title
    @author = author
    @rentals = []
    @id = id
  end

  # def id
  #   @id
  # end

  def add_rental(rental)
    rentals << rental
  end

  # def generate_id
  #   Random.rand(1...1000)
  # end

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

