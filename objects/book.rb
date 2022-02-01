require 'date'
require 'time'
require_relative '../services/object_setter'
require_relative '../services/language'

class Book
  extend ObjectSetter
  extend Language

  ATTRIBUTES = ['id', 'name', 'written_date', 'created_at', 'updated_at', 'author_id', 'price']

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

  def self.choose_book(choice, books)
    book = books.find { |book| book.id == choice }
    p phrases_list[:book_info]
    p "Name: #{book.name}"
    p "ID: #{book.id}"
    p "Price: #{book.price}"
    p phrases_list[:confirm_payment]
    choice = gets.chomp
    case choice.downcase
    when 'buy'
      book
    else
      p phrases_list[:choose_author]
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

  def self.create
    new_object(ATTRIBUTES)
  end

  def self.buy_book
    choice = Author.authors_list(Storage.get_authors)
    book = choose_book(choice, books = Storage.get_books)
    client = Client.client_info(Storage.get_clients)
    Order.payment_order(book, client)
  end
end
