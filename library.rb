require_relative './objects/order'
require_relative './services/rating'
require_relative './services/language'
require_relative './services/file_handler'
require_relative './objects/author'
require_relative './objects/book'
require_relative './objects/client'
require_relative './services/object_setter'
require_relative './services/library_helper'

class Library
  extend ObjectSetter
  include Language
  include LibraryHelper
  attr_reader :books, :authors, :clients, :orders

  def initialize
    @books = []
    @authors = []
    @clients = []
    @rating = []
    @orders = []
  end

  def get_collections(name, &block)
    file = FileHandler.new(name).parse_file
    file.each(&block)
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
    @clients
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

  def load_files
    @authors = parse_authors
    @books = parse_books
    @clients = parse_clients
    @orders = parse_orders
  end

  def client_info
    p phrases_list[:new_client]
    answer = gets.chomp.downcase
    until answer == phrases_list[:yes] || answer == phrases_list[:no]
      p "That's not the anwser we've expected. Let's try once again"
      answer = gets.chomp
    end
    if answer == phrases_list[:yes]
      p created_client = Client.new_client(clients = @clients)
      file = FileHandler.new('clients').parse_file
      file.push(created_client)
      FileHandler.new('clients').write_file(file)
      client = Client.new(created_client['id'], created_client['first_name'], created_client['last_name'], created_client['address'])
    elsif answer == phrases_list[:no]
      p phrases_list[:enter_details]
      full_name = gets.chomp
      client = Client.locate_client(clients = @clients, full_name)
    end
    client
  end

  def write_order(book, client)
    order = Order.new_order(book, client)
    file = FileHandler.new('orders').parse_file
    file.push(order)
    FileHandler.new('orders').write_file(file)
    puts phrases_list[:payment_accepted]
  end

  def buy_book
    load_files
    choice = Author.authors_list(authors = @authors)
    book = Book.buy_book(choice, books = @books)
    client = client_info
    write_order(book, client)
  end


  def add_entity(file_name, new_entity)
    file = FileHandler.new(file_name).parse_file
    file.push(new_entity)
    FileHandler.new(file_name).write_file(file)
  end

  def run
    parse_authors
    parse_books
    parse_clients
    parse_orders
    choose_version
    greeting
    loop do
      commands
      print phrases_list[:command]
      input = gets.chomp
      command = command_converter(input)
      n_times = input.to_i
      if command == COMMANDS[0]
        buy_book
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
        add_entity('books', new_book)
      elsif command == COMMANDS[10]
        new_author = Author.create
        add_entity('authors', new_author)
      elsif command == COMMANDS[11]
        new_client = Client.create
        add_entity('clients', new_client)
      elsif command == COMMANDS[12]
        new_order = Order.create
        add_entity('orders', new_order)
      elsif command == COMMANDS[13]
        return
      else
        puts phrases_list[:invalid_command]
      end
    end
  end
end
