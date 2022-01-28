require 'date'
require 'time'
require_relative '../service/object_creator'
require_relative '../service/language'

class Book
  extend ObjectCreator
  extend Language
  attr_reader :id, :name, :written_date, :created_at, :updated_at, :author_id, :price

  def initialize(id, name, written_date, created_at, updated_at, author_id, price)
    @id = id
    @name = name
    @written_date = written_date
    @created_at = created_at
    @updated_at = updated_at
    @author_id = author_id
    @price = price
  end

  def self.buy_book(choice, books)
    book = books.find { |book| book.id == choice }
    p phrases_list[:book_info]
    p "Name: #{book.name}"
    p "ID: #{book.id}"
    p "Price: #{book.price}"
    p 'Do you wish to buy a book?'
    choice = gets.chomp
    case choice.downcase
    when 'buy'
      book
    else
      p 'Please choose your author:'
      choice = gets.chomp
      buy_book(choice, books)
    end
    book
  end

  def payment_actions
    @confirm = gets.chomp
    while @confirm.downcase != phrases_list[:buy]
      wrong_input_check
      book_info
      @confirm = gets.chomp
    end
  end

  def self.add_book(file_name)
    create_file(file_name)
  end
end
