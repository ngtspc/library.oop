# frozen_string_literal: true

# require_relative '../service/file_handler'
require_relative '../service/language'
require_relative '../service/object_creator'

# Description/Explanation of Author class
class Author
  extend ObjectCreator
  extend Language
  attr_reader :first_name, :last_name, :book_id

  def initialize(first_name, last_name, book_id)
    @first_name = first_name
    @last_name = last_name
    @book_id = book_id
  end

  def self.authors_list(authors)
    authors.each do |author|
      p "#{author.book_id}. #{author.first_name} #{author.last_name}"
    end
    p phrases_list[:choose_author]
    choice = gets.chomp
    until choice.to_i > 0 && choice.to_i < 8
      p 'please double-check your input'
      choice = gets.chomp
    end
    choice
  end

  def self.add_author(file_name)
    create_file(file_name)
  end
end
