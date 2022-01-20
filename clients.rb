require_relative 'file_handler'
require_relative 'orders'
require_relative 'book'
require_relative 'language'

class Clients < Rating
  include Language
  attr_reader :clients, :orders

  def initialize(clients = FileHandler.new('clients'))
    @clients = clients
    super()
  end

  def set_new_client_info
    puts phrases_list[:info]
    array_clients = clients.parse_file
    id = clients.parse_file.last["id"].to_i + 1
    print phrases_list[:enter_name]
    first_name = gets.chomp
    print phrases_list[:enter_surname]
    last_name = gets.chomp
    print phrases_list[:enter_address]
    address = gets.chomp
    client = {
        "id" => id,
        "first_name" => first_name,
        "last_name" => last_name,
        "address" => address,
    }
    array_clients.push(client)
    clients.write_file(array_clients)
    client
  end

  def set_client_info
    puts phrases_list[:new_client]
    confirm = gets.chomp
    if confirm == phrases_list[:yes]
      client = set_new_client_info
    elsif confirm == phrases_list[:no]
      puts phrases_list[:enter_details]
      full_name = gets.chomp
      array_clients = clients.parse_file
      client = array_clients.find { |buyer| "#{buyer['first_name']} #{buyer['last_name']}" == full_name }
    end
    until client != nil
      client = set_new_client_info
    end
    client
  end

  def order_creation(client, located_book)
    time_real = Time.new.strftime("%F")
    hash_of_order = {
      "book_id" => "#{located_book['id']}",
      "created_at" => time_real,
      "client_id" => "#{client['id'].to_i}",
      "payed" => "#{located_book['price']}"
    }
    orders.push(hash_of_order)
    FileHandler.new('orders').write_file(orders)
    puts phrases_list[:payment_accepted]
    p '-' * 60
  end
end
