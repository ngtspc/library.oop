require_relative '../service/language'
require_relative '../service/object_setter'

class Client
  extend ObjectSetter
  extend Language

  CLIENT_ATTRIBUTES = ['book_id', 'created_at', 'client_id', 'payed']

  attr_reader :id, :first_name, :last_name, :address

  def initialize(id, first_name, last_name, address)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @address = address
  end

  def self.locate_client(clients, full_name)
    client = clients.find { |client| "#{client.first_name} #{client.last_name}" == full_name }
  end

  def self.new_client(clients = @clients)
    puts phrases_list[:info]
    max_id_client = clients.max_by(&:id)
    id = max_id_client.id + 1
    print phrases_list[:enter_name]
    first_name = gets.chomp
    print phrases_list[:enter_surname]
    last_name = gets.chomp
    print phrases_list[:enter_address]
    address = gets.chomp
    client = {
      'id' => id,
      'first_name' => first_name,
      'last_name' => last_name,
      'address' => address
    }
    clients.push(client)
    client
  end

  def self.add_client
    create_file(CLIENT_ATTRIBUTES)
  end
end
