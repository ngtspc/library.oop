require_relative 'book'
require_relative '../services/language'
require_relative '../services/rating'
require_relative '../services/object_setter'

class Order
  extend ObjectSetter
  extend Language
  extend Rating

  ORDER_ATTRIBUTES = ['book_id', 'created_at', 'client_id', 'payed']

  attr_reader :book_id, :created_at, :client_id, :payed

  def initialize(book_id, created_at, client_id, payed)
    @book_id = book_id
    @created_at = created_at
    @client_id = client_id
    @payed = payed
  end

  def self.profit(orders)
    pp orders.length
    profit = orders.map { |order| order.payed.to_i }.sum
    puts "#{phrases_list[:profit]} #{profit}$"
  end

  def self.payment_order(book, client)
    order = order_info(book, client)
    file = FileHandler.parse_file('orders')
    file.push(order)
    FileHandler.write_file('orders' ,file)
    puts phrases_list[:payment_accepted]
  end

  def self.order_info(book, client)
    time_real = Time.new.strftime('%F')
    order = {
      "book_id": book.id.to_s,
      "created_at": time_real,
      "client_id": client.id.to_s,
      "payed": book.price.to_s
    }
  end

  def self.books_rate(n_times, orders, books)
    top_n(n_times, orders, 'book_id', books, 'id') { |id, index, top_entities| p "#{index + 1}. #{top_entities.name}, book id:#{top_entities.id}" }
  end

  def self.authors_rate(n_times, orders, authors)
    top_n(n_times, orders, 'book_id', authors, 'book_id') { |id, index, top_entities| p "#{index + 1}. #{top_entities.first_name} #{top_entities.last_name}" }
  end

  def self.clients_rate(n_times, orders, clients)
    top_n(n_times, orders, 'client_id', clients, 'id') { |id, index, top_entities| p "#{index + 1}. #{top_entities.first_name} #{top_entities.last_name}" } 
  end

  def self.create
    new_object(ORDER_ATTRIBUTES)
  end
end
