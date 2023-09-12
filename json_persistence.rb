require 'json'



module JsonPersistence
  def self.save_to_json(filename, data)
    File.open(filename, 'w') do |file|
      file.puts JSON.generate(data)
    end
  rescue JSON::GeneratorError => e
    puts "Error while generating JSON: #{e.message}"
  rescue StandardError => e
    puts "Unknown error while saving data to JSON: #{e.message}"
  end

  def self.load_from_json(filename)
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
