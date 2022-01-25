# frozen_string_literal: true

require_relative '../service/file_handler'

# Description/Explanation of Author Class
class Author
  attr_reader :authors

  def initialize(authors)
    @authors = converted_file(authors)
  end

  def converted_file(authors)
    authors.each { |hash| hash['book_id'] = hash['book_id'].to_i }
  end

  def authors_list
    @authors.each do |name|
      puts "#{name['book_id']}.#{name['first_name']} #{name['last_name']}"
    end
  end
end
