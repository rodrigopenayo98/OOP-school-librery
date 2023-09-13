require 'json'

module JsonPersistence
  def load_from_json(filename)
    return [] unless File.exist?(filename)

    begin
      data = JSON.parse(File.read(filename))
    rescue JSON::ParserError => e
      puts "Error while parsing JSON file: #{e.message}"
      data = []
    end

    data
  end
end
