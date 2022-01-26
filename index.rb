require 'json'

def write_file(database)
  File.open("./json_files/gavno.json", 'w') do |file|
    file.write(JSON.pretty_generate(database))
  end
  file = File.read("./json_files/gavno.json")
  JSON.parse(file)
end

def parse_file
  database = []
  if File.exist?("./json_files/gavno.json")
    file = File.read("./json_files/gavno.json")
    JSON.parse(file)
  else
    filling_file(database)
  end
end

def filling_file(database)
  p !File.empty?("./json_files/gavno.json")
  if !File.empty?("./json_files/gavno.json")
    p "The file gavno is empty at the moment. Please use a command 'add' or 'exit'."
    confirm = gets.chomp
    if confirm == 'add'
      p database = create_file(n = gets.chomp.to_i)
      write_file(database)
    else
      p 'не зашло'
    end
  end
end

def create_file(n = gets.chomp.to_i)
  database = []
  hash = {}
  n.times do |key, value|
    p "Vvedite key"
    key = gets.chomp
    p "Vvedite value"
    value = gets.chomp
    hash1 = {
      "#{key}" => value
    }
    p hash1
    # hash.merge(hash1)
    # p hash
    database.push(hash1)
  end
  database
end

parse_file