# frozen_string_literal: true

require_relative '../service/file_handler'
require_relative 'book'
require_relative 'client'
require_relative '../service/language'

# Description/Explanation of Order Class
class Order
  include Language
  attr_reader :orders, :books, :clients

  def initialize(orders)
    @orders = orders
  end

  def profit
    profit = @orders.map { |hash| hash['payed'].to_i }.sum
    puts "#{phrases_list[:profit]} #{profit}$"
  end

  def new_order(book, client)
    time_real = Time.new.strftime('%F')
    order = {
      'book_id' => book['id'].to_s,
      'created_at' => time_real,
      'client_id' => client['id'].to_s,
      'payed' => book['price'].to_s
    }
    @orders.push(order)
    FileHandler.new('orders').write_file(@orders)
    puts phrases_list[:payment_accepted]
  end
end

