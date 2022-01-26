# frozen_string_literal: true

require_relative '../service/file_handler'
require_relative '../service/language'

# Description/Explanation of Client Class
class Client
  include Language
  attr_reader :id, :first_name, :last_name, address

  def initialize(id, first_name, last_name, address)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @address = address
  end

  def converted_file(file)
    file.each { |hash| hash['id'] = hash['id'].to_i }
  end

  def locate_client
    @clients.find { |client| "#{client['first_name']} #{client['last_name']}" == @full_name }
  end

  def info
    p phrases_list[:new_client]
    @answer = gets.chomp
    until @answer == phrases_list[:yes] || @answer == phrases_list[:no]
      p "That's not the anwser we've expected. Let's try once again"
      @answer = gets.chomp
    end
    if @answer == phrases_list[:yes]
      @client = new_client
    elsif @answer == phrases_list[:no]
      p phrases_list[:enter_details]
      @full_name = gets.chomp
      @client = locate_client
    end
    @client = new_client until @client
    @client
  end

  def new_client
    puts phrases_list[:info]
    @id = @clients.last['id'].to_i + 1
    print phrases_list[:enter_name]
    first_name = gets.chomp
    print phrases_list[:enter_surname]
    last_name = gets.chomp
    print phrases_list[:enter_address]
    address = gets.chomp
    @client = fill_info(first_name, last_name, address)
    @clients.push(client)
    FileHandler.new('clients').write_file(@clients)
    @client
  end

  def fill_info(first_name, last_name, address)
    @client = {
      'id' => @id,
      'first_name' => first_name,
      'last_name' => last_name,
      'address' => address
    }
  end
end
