# frozen_string_literal: true

require_relative './objects/order'
require_relative './service/rating'
require_relative './service/language'
require_relative './service/file_handler'
require_relative './objects/author'
require_relative './objects/book'
require_relative './objects/client'

# Description/Explanation of Author Class
class Library
  include Language
  attr_reader :books, :authors, :clients, :orders

  def initialize
    @books = []
    @authors = []
    @clients = []
    @rating = ''
    @orders = []
  end

  def get_collections(name)
    file = FileHandler.new(name).parse_file
    file.each do |object|
      yield object
    end
  end

  def parse_books
    get_collections('books') do |object|
      entity = Book.new(object['id'],
                        object['name'],
                        DateTime.parse(object['written_date']),
                        DateTime.parse(object['created_at']),
                        DateTime.parse(object['updated_at']),
                        object['author_id'].to_i,
                        object['price'].to_i)
      @books.push(entity)
    end
    @books
  end

  def parse_authors
    get_collections('authors') do |object|
      entity = Author.new(object['first_name'],
                          object['last_name'],
                          object['book_id'].to_i)
      @authors.push(entity)
    end
    @authors
  end

  def parse_clients
    get_collections('clients') do |object|
      entity = Client.new(object['id'].to_i,
                          object['first_name'],
                          object['last_name'],
                          object['address'])
      @clients.push(entity)
    end
  end

  def parse_orders
    get_collections('orders') do |object|
      entity = Order.new(object['book_id'].to_i,
                         DateTime.parse(object['created_at']),
                         object['client_id'].to_i,
                         object['payed'].to_i)
      @orders.push(entity)
    end
    @orders
  end
#################################################################################
  def buy_book
    @authors.authors_list
    book = @books.wrong_input_check
    @books.book_info
    @books.payment_actions
    client = @clients.info
    @orders.new_order(book, client)
  end

  def command_converter(input)
    input = input.split('-')
    input.delete_at(0) if input.size > 1
    input.join('')
  end

  def run
    choose_version
    greeting
    loop do
      commands
      print phrases_list[:command]
      input = gets.chomp
      command = command_converter(input)
      ntimes = input.to_i
      if command == COMMANDS[0]
        @authors.authors_list
      elsif command == COMMANDS[1]
        buy_book
      elsif command == COMMANDS[2]
        @orders.profit
      elsif command == COMMANDS[3]
        @rating.top_books(ntimes)
      elsif command == COMMANDS[4]
        @rating.top_authors(ntimes)
      elsif command == COMMANDS[5]
        @rating.top_clients(ntimes)
      elsif command == COMMANDS[6]
        pp @books
      elsif command == COMMANDS[7]
        pp @authors
      elsif command == COMMANDS[8]
        pp @clients
      elsif command == COMMANDS[9]
        pp @orders
      elsif command == COMMANDS[10]
        return
      else
        puts phrases_list[:invalid_command]
      end
    end
  end
end

library = Library.new()
pp library.parse_orders