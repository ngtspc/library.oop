# frozen_string_literal: true

require_relative 'file_handler'
require_relative 'language'
require_relative 'orders'

# Description/Explanation of Orders class
class Orders
  include Language
  attr_reader :orders

  def initialize(orders = FileHandler.new('orders').parse_file)
    @orders = orders
  end

  def total_profit
    profit = orders.map { |hash| hash['payed'].to_i }.sum
    puts "#{phrases_list[:profit]} #{profit}$"
  end
end
