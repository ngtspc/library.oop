# frozen_string_literal: true

require_relative 'file_handler'

# Description/Explanation of Rating module
module Rating
  def top_ids(n_times, orders, key_name)
    orders.group_by { |object| object.instance_variable_get("@#{key_name}") }
          .transform_values(&:count)
          .sort_by { |_key, count| - count }[0...n_times]
          .to_h
          .keys
  end

  def top_books(_n_times, orders, books, top_ids)
    if orders.empty?
      p 'Unfortunately, this database is empty at the moment.'
    else
      top_ids.each_with_index do |id, index|
        hash_top_ids = books.find { |book| book.id.to_i == id.to_i }
        p "#{index + 1}. #{hash_top_ids.name}, book id:#{hash_top_ids.id}"
      end
    end
  end

  def top_authors(_n_times, orders, authors, top_ids)
    if orders.empty?
      p 'Unfortunately, this database is empty at the moment.'
    else
      top_ids.each_with_index do |id, index|
        hash_top_ids = authors.find { |author| author.book_id.to_i == id.to_i }
        p "#{index + 1}. #{hash_top_ids.first_name} #{hash_top_ids.last_name}"
      end
    end
  end

  def top_clients(_n_times, orders, clients, top_ids)
    if orders.empty?
      p 'Unfortunately, our database is empty at the moment.'
    else
      top_ids.each_with_index do |id, index|
        hash_top_ids = clients.find { |object| object.id.to_i == id.to_i }
        p "#{index + 1}. #{hash_top_ids.first_name} #{hash_top_ids.last_name}"
      end
    end
  end
end
