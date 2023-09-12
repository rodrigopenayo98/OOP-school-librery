class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    book.add_rental(self)
    person.add_rental(self)
  end

  # to data project --------------------------
  def to_json(_options = {})
    {
      date: @date,
      book: @book.to_json,
      person: @person.to_json
    }.to_json
  end

  # to data project --------------------------
end
