require_relative 'app'

class Main
  def initialize
    @app = App.new
    # to data project --------------------------
    load_data_from_json
    # to data project --------------------------
  end

  def run
    @app.run
    # to data project --------------------------
    save_data_to_json
    # to data project --------------------------
  end

  # to data project --------------------------
  private

  def load_data_from_json
    # @app.load_books_from_json
    @app.load_people_from_json
    # @app.load_rentals_from_json
  end

  def save_data_to_json
    # @app.save_books_to_json
    @app.save_people_to_json
    # @app.save_rentals_to_json
  end
  # to data project --------------------------
end

Main.new.run if __FILE__ == $PROGRAM_NAME
