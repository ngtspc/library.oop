require_relative '../services/language'
require_relative '../services/object_setter'

class Client
  extend ObjectSetter
  extend Language

  ATTRIBUTES = ['book_id', 'created_at', 'client_id', 'payed']

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
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "address": address
    }
    clients.push(client)
    client
  end

  def self.client_info(clients = Storage.clients)
    p phrases_list[:new_client]
    answer = gets.chomp.downcase
    until answer == phrases_list[:yes] || answer == phrases_list[:no]
      p phrases_list[:double_check]
      answer = gets.chomp
    end
    if answer == phrases_list[:yes]
      p created_client = Client.new_client(clients)
      Storage.add('clients', created_client)
      client = Client.locate_client(clients = Storage.get_clients, "#{created_client[:first_name]} #{created_client[:last_name]}")
    elsif answer == phrases_list[:no]
      p phrases_list[:enter_details]
      full_name = gets.chomp
      client = Client.locate_client(clients = Storage.get_clients, full_name)
    end
    p client
  end

  def self.create
    new_object(ATTRIBUTES)
  end
end
