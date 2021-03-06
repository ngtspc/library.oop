require 'json'

class FileHandler
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def self.write_file(file_path, database)
    File.open("./json_files/#{file_path}.json", 'w') do |file|
      file.write(JSON.pretty_generate(database))
    end
    file = File.read("./json_files/#{file_path}.json")
    JSON.parse(file)
  end

  def self.parse_file(file_path)
    database = []
    if File.exist?("./json_files/#{file_path}.json")
      file = File.read("./json_files/#{file_path}.json")
      JSON.parse(file)
    else
      write_file(database)
    end
  end
end
