# frozen_string_literal: true

require_relative 'file_handler'

# Description/Explanation of Authors class
class Authors < Rating
  attr_reader :authors, :orders

  def initialize(authors = FileHandler.new('authors'))
    @authors = authors
    super()
  end

  def list_of_authors
    p orders
    authors.parse_file.each do |name|
      puts "#{name['book_id']}.#{name['first_name']} #{name['last_name']}"
    end
  end
end
