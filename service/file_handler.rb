# frozen_string_literal: true

require 'json'

# Description/Explanation of FileHandler Class
class FileHandler
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def write_file(database)
    File.open("./json_files/#{file_path}.json", 'w') do |file|
      file.write(JSON.pretty_generate(database))
    end
    file = File.read("./json_files/#{@file_path}.json")
    JSON.parse(file)
  end

  def parse_file
    if File.exist?("./json_files/#{@file_path}.json")
      file = File.read("./json_files/#{@file_path}.json")
      JSON.parse(file)
    else
      database = []
      write_file(database)
    end
  end
end
