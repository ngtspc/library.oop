require_relative './objects/order'
require_relative './services/rating'
require_relative './services/language'
require_relative './services/file_handler'
require_relative './objects/author'
require_relative './objects/book'
require_relative './objects/client'
require_relative './services/object_setter'
require_relative './services/library_helper'
require_relative 'storage'

class Library
  include Language
  include LibraryHelper
  attr_reader :books, :authors, :clients, :orders

  def initialize
    @books = Storage.get_books
    @authors = Storage.get_authors
    @clients = Storage.get_clients
    @orders = Storage.get_orders
  end

  def run
    choose_version
    greeting
    loop do
      commands
      print phrases_list[:command]
      input = gets.chomp
      command = command_converter(input)
      n_times = input.to_i
      if command == COMMANDS[0]
        Book.buy_book
      elsif command == COMMANDS[1]
        Order.profit(orders = @orders)
      elsif command == COMMANDS[2]
        top_ids = Order.books_rate(n_times, orders = @orders, books = @books)
      elsif command == COMMANDS[3]
        top_ids = Order.authors_rate(n_times, orders = @orders, authors = @authors)
      elsif command == COMMANDS[4]
        top_ids = Order.clients_rate(n_times, orders = @orders, clients = @clients)
      elsif command == COMMANDS[5]
        pp @books
      elsif command == COMMANDS[6]
        pp @authors
      elsif command == COMMANDS[7]
        pp @clients
      elsif command == COMMANDS[8]
        pp @orders
      elsif command == COMMANDS[9]
        new_book = Book.create
        Storage.add('books', new_book)
      elsif command == COMMANDS[10]
        new_author = Author.create
        Storage.add('authors', new_author)
      elsif command == COMMANDS[11]
        new_client = Client.create
        Storage.add('clients', new_client)
      elsif command == COMMANDS[12]
        new_order = Order.create
        Storage.add('orders', new_order)
      elsif command == COMMANDS[13]
        return
      else
        puts phrases_list[:invalid_command]
      end
    end
  end
end
