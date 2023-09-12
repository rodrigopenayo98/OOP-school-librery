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
  def to_json
    {
      title: @title,
      author: @author
    }
  end
  # to data project --------------------------
end
