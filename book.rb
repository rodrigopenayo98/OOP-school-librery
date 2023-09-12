class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    rentals << rental
  end

  # to data project --------------------------
  def to_json(_options = {})
    {
      title: @title,
      author: @author
    }.to_json
  end
  # to data project --------------------------
end
