# frozen_string_literal: true

require_relative 'file_handler'

# Description/Explanation of Rating Class
class Rating
  attr_reader :orders, :books, :authors, :clients

  def initialize(orders, books, authors, clients)
    @orders = orders
    @books = books
    @authors = authors
    @clients = clients
  end

  def top_ids(key_name, ntimes)
    @orders.group_by { |hash| hash[key_name] }
           .transform_values(&:count)
           .sort_by { |_key, count| - count }[0...ntimes]
           .to_h
           .keys
  end

  def top_books(ntimes)
    if @orders.instance_of?(Integer) || @orders.empty?
      p 'Unfortunately, this database is empty at the moment.'
    else
      top_ids('book_id', ntimes).each_with_index do |id, index|
        hash_top_ids = @books.find { |entity| entity['id'].to_s == id }
        p "#{index + 1}. #{hash_top_ids['name']}, book id:#{hash_top_ids['id']}"
      end
    end
  end

  def top_authors(ntimes)
    if @orders.instance_of?(Integer) || @orders.empty?
      p 'Unfortunately, this database is empty at the moment.'
    else
      top_ids('book_id', ntimes).each_with_index do |id, index|
        hash_top_ids = @authors.find { |entity| entity['book_id'].to_s == id }
        p "#{index + 1}. #{hash_top_ids['first_name']} #{hash_top_ids['last_name']}"
      end
    end
  end

  def top_clients(ntimes)
    if @orders.instance_of?(Integer) || @orders.empty?
      p 'Unfortunately, our database is empty at the moment.'
    else
      top_ids('client_id', ntimes).each_with_index do |id, index|
        hash_top_ids = @clients.find { |entity| entity['id'].to_s == id }
        p "#{index + 1}. #{hash_top_ids['first_name']} #{hash_top_ids['last_name']}"
      end
    end
  end
end