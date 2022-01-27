# frozen_string_literal: true

require_relative 'book'
require_relative 'book'
require_relative '../service/language'
require_relative '../service/rating'
require_relative '../service/object_creator'

# Description/Explanation of Order сlass
class Order
  extend ObjectCreator
  extend Language
  extend Rating

  attr_reader :book_id, :created_at, :client_id, :payed

  def initialize(book_id, created_at, client_id, payed)
    @book_id = book_id
    @created_at = created_at
    @client_id = client_id
    @payed = payed
  end

  def self.profit(orders)
    profit = orders.map { |order| order.payed.to_i }.sum
    puts "#{phrases_list[:profit]} #{profit}$"
  end

  def self.new_order(book, client)
    time_real = Time.new.strftime('%F')
    order = {
      'book_id' => book.id.to_s,
      'created_at' => time_real,
      'client_id' => client.id.to_s,
      'payed' => book.price.to_s
    }
  end

  def self.books_rate(n_times, orders, books)
    top_ids = top_ids(n_times, orders, 'book_id')
    top_books(n_times, orders, books, top_ids)
  end

  def self.authors_rate(n_times, orders, authors)
    top_ids = top_ids(n_times, orders, 'book_id')
    top_authors(n_times, orders, authors, top_ids)
  end

  def self.clients_rate(n_times, orders, clients)
    top_ids = top_ids(n_times, orders, 'client_id')
    top_clients(n_times, orders, clients, top_ids)
  end

  def self.add_order(file_name)
    create_file(file_name)
  end
end
