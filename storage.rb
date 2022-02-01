require_relative './services/file_handler'
require_relative './objects/book'
require_relative './services/language'

class Storage
  extend Language 
  attr_reader :authors, :books, :clients, :orders

  def initialize
    @authors = get_authors
    @books = get_books
    @clients = get_clients
    @orders = get_orders
  end

  def self.get_collections(name, &block)
    file = FileHandler.parse_file(name)
    file.each(&block)
  end

  def self.get_books
    collection = []
    get_collections('books') do |object|
      entity = Book.new(object['id'],
                        object['name'],
                        DateTime.parse(object['written_date']),
                        DateTime.parse(object['created_at']),
                        DateTime.parse(object['updated_at']),
                        object['author_id'].to_i,
                        object['price'].to_i)
      collection.push(entity)
    end
    collection
  end

  def self.get_authors
    collection = []
    get_collections('authors') do |object|
      entity = Author.new(object['first_name'],
                          object['last_name'],
                          object['book_id'].to_i)
      collection.push(entity)
    end
    collection
  end

  def self.get_clients
    collection = []
    get_collections('clients') do |object|
      entity = Client.new(object['id'].to_i,
                          object['first_name'],
                          object['last_name'],
                          object['address'])
      collection.push(entity)
    end
    collection
  end

  def self.get_orders
    collection = []
    get_collections('orders') do |object|
      entity = Order.new(object['book_id'].to_i,
                         DateTime.parse(object['created_at']),
                         object['client_id'].to_i,
                         object['payed'].to_i)
      collection.push(entity)
    end
    collection
  end

  def self.add(file_name, new_entity)
    file = FileHandler.parse_file(file_name)
    file.push(new_entity)
    FileHandler.write_file(file_name, file)
  end
end
