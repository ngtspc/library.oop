require_relative 'file_handler'
require_relative 'orders'

class Rating
  attr_reader :orders

  def initialize(orders = FileHandler.new('orders').parse_file)
    @orders = orders
  end

  def top_ids(ntimes, orders_key)
    orders.group_by { |hash| hash[orders_key] }
          .transform_values(&:count)
          .sort_by { |_key, count| - count }[0...ntimes]
          .to_h
          .keys
  end

  def top_n(ntimes, orders_key, file, key_name)
    top_ids(ntimes, orders_key).each_with_index do |id, index|
      hash_top_ids = file.find { |entity| entity[key_name].to_s == id }
      yield index, hash_top_ids
    end
  end
end
