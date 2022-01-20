# frozen_string_literal: true

require_relative 'rating'
require_relative 'authors'
require_relative 'book'
require_relative 'clients'
require_relative 'orders'
require_relative 'file_handler'
require_relative 'language'
require 'date'
require 'time'

# Description/Explanation of Rating class
class Library < Orders
  include Language
  attr_reader :authors_lib, :books_lib, :clients_lib

  def initialize(authors_lib = Authors.new,
                 books_lib = Books.new,
                 clients_lib = Clients.new)
    @authors_lib = authors_lib
    @books_lib = books_lib
    @clients_lib = clients_lib
    super()
  end

  COMMANDS = %w[get_list buy_book profit top_books top_authors top_clients show_books show_authors show_clients show_orders exit].freeze

  def greeting
    puts phrases_list[:greeting]
  end

  def commands
    puts phrases_list[:get_list]
    COMMANDS.each do |name|
      p name
    end
  end

  def buy_book
    authors_lib.list_of_authors
    book_id = books_lib.input_check
    located_book = books_lib.find_book_by_id(book_id)
    books_lib.get_book_info(located_book)
    books_lib.payment_actions
    client = clients_lib.set_client_info
    clients_lib.order_creation(client, located_book)
  end

  def top_books(ntimes, orders_key)
    books_lib.top_n(ntimes, orders_key, books_lib.books.parse_file, 'id') do |index, hash_top_ids|
      p "#{index + 1}. #{hash_top_ids['name']}, book id:#{hash_top_ids['id']}"
    end
  end

  def top_authors(ntimes, orders_key)
    authors_lib.top_n(ntimes, orders_key, authors_lib.authors.parse_file, 'book_id') do |index, hash_top_ids|
      p "#{index + 1}. #{hash_top_ids['first_name']} #{hash_top_ids['last_name']}"
    end
  end

  def top_clients(ntimes, orders_key)
    clients_lib.top_n(ntimes, orders_key, clients_lib.clients.parse_file, 'id') do |index, hash_top_ids|
      p "#{index + 1}. #{hash_top_ids['first_name']} #{hash_top_ids['last_name']}"
    end
  end

  def set_mode(input)
    input = input.split('-')
    input.delete_at(0) if input.size > 1
    input.join('')
  end

  def read_file(file_name, &block)
    entity = FileHandler.new(file_name).parse_file
    entity.each { |hash| block.call hash }
    pp entity
  end

  def show_books
    read_file('books') do |hash|
      hash['id'] = hash['id'].to_i
      hash['written_date'] = DateTime.parse(hash['written_date'])
      hash['created_at'] = DateTime.parse(hash['created_at'])
      hash['update_at'] = DateTime.parse(hash['updated_at'])
      hash['author_id'] = hash['author_id'].to_i
      hash['price'] = hash['id'].to_i
    end
  end

  def show_authors
    read_file('authors') { |hash| hash['book_id'] = hash['book_id'].to_i }
  end

  def show_clients
    read_file('clients') { |hash| hash['id'] = hash['id'].to_i }
  end

  def show_orders
    read_file('orders') do |hash|
      hash['book_id'] = hash['book_id'].to_i
      hash['created_at'] = DateTime.parse(hash['created_at'])
      hash['client_id'] = hash['client_id'].to_i
      hash['payed'] = hash['payed'].to_i
    end
  end

  def run
    choose_version
    greeting
    loop do
      commands
      print phrases_list[:command]
      input = gets.chomp
      command = set_mode(input)
      ntimes = input.to_i
      if command == COMMANDS[0]
        authors_lib.list_of_authors
      elsif command == COMMANDS[1]
        buy_book
      elsif command == COMMANDS[2]
        total_profit
      elsif command == COMMANDS[3]
        top_books(ntimes, 'book_id')
      elsif command == COMMANDS[4]
        top_authors(ntimes, 'book_id')
      elsif command == COMMANDS[5]
        top_clients(ntimes, 'client_id')
      elsif command == COMMANDS[6]
        show_books
      elsif command == COMMANDS[7]
        show_authors
      elsif command == COMMANDS[8]
        show_clients
      elsif command == COMMANDS[9]
        show_orders
      elsif command == COMMANDS[10]
        return
      else
        puts phrases_list[:invalid_command]
      end
    end
  end
end
