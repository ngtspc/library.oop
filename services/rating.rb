require_relative 'file_handler'

module Rating
  def top_ids(n_times, orders, key_name)
    orders.group_by { |object| object.send("#{key_name}") }
          .transform_values(&:count)
          .sort_by { |_key, count| - count }[0...n_times]
          .to_h
          .keys
  end

  def top_n(n_times, orders, key_name, collection, key_name2)
    if orders.empty?
      p phrases_list[:empty_database]
    else
      top_ids(n_times, orders, key_name).each_with_index do |id, index|
        top_entities = collection.find { |entity| entity.send("#{key_name2}").to_i == id.to_i }
        yield id, index, top_entities
      end
    end
  end
end
