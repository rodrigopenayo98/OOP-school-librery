class Rental
  attr_accessor :date, :title, :person, :person_id, :book_id

  def initialize(date, title, person, person_id, book_id)
    @date = date
    @title = title
    @person = person
    @person_id = person_id
    @book_id = book_id

    # book.add_rental(self)
    # person.add_rental(self)
  end

  # to data project --------------------------
  def to_json(_options = {})
    {
      date: @date,
      title: @title,
      person: @person.to_json,
      person_id: @person_id,
      book_id: @book_id
    }.to_json
  end
  # to data project --------------------------
end
