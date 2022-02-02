require_relative '../services/language'
require_relative '../services/object_setter'

class Author
  extend ObjectSetter
  extend Language

  ATTRIBUTES = ['first_name', 'last_name', 'book_id']

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
    until choice.to_i.positive? && authors.max_by(&:book_id)
      p phrases_list[:double_check]
      choice = gets.chomp
    end
    choice
  end

  def self.create
    new_object(ATTRIBUTES)
  end
end
