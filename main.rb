require_relative 'app'

class Main
  def initialize
    @app = App.new
    load_data_from_json
  end

  def run
    @app.run
  end

  private

  def load_data_from_json
    @app.load_data
  end
end

Main.new.run if __FILE__ == $PROGRAM_NAME
