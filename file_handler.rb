require 'json'

class FileHandler
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end
  
  def parse_file
    file = File.read("./json_files/#{@file_path}.json")
    JSON.parse(file)
  end

  def write_file(database)
    File.open("./json_files/#{file_path}.json", "w") do |file|
      file.write(JSON.pretty_generate(database))
    end
  end 

end
