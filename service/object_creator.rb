# frozen_string_literal: true

# Description/Explanation of ObjectCreator module
module ObjectCreator
  def create_file(file_name)
    case file_name
    when 'book'
      p 'Please enter id: '
      id = gets.chomp
      p 'Please enter name: '
      name = gets.chomp
      p 'Please enter written_at: '
      written_date = gets.chomp
      p 'Please enter created_at: '
      created_at = gets.chomp
      p 'Please enter updated_at: '
      updated_at = gets.chomp
      p 'Please enter author_id: '
      author_id = gets.chomp
      p 'Please enter price: '
      price = gets.chomp
      attribute = { 'id' => id,
                    'name' => name,
                    'written_date' => written_date,
                    'created_at' => created_at,
                    'updated_at' => updated_at,
                    'author_id' => author_id,
                    'price' => price }
    when 'author'
      p 'Please enter first name: '
      first_name = gets.chomp
      p 'Please enter last name: '
      last_name = gets.chomp
      p 'Please enter book id: '
      book_id = gets.chomp
      attribute = { 'first_name' => first_name,
                    'last_name' => last_name,
                    'book_id' => book_id }
    when 'client'
      p 'Please enter id: '
      id = gets.chomp
      p 'Please enter first name: '
      first_name = gets.chomp
      p 'Please enter last_name: '
      last_name = gets.chomp
      p 'Please enter address: '
      address = gets.chomp
      attribute = { 'id' => id.to_i,
                    'first_name' => first_name,
                    'last_name' => last_name,
                    'address' => address }
    when 'order'
      p 'Please enter book id: '
      book_id = gets.chomp
      p 'Please enter created_at: '
      created_at = gets.chomp
      p 'Please enter client_id: '
      client_id = gets.chomp
      p 'Please enter payed: '
      payed = gets.chomp
      attribute = { 'book_id' => book_id,
                    'created_at' => created_at,
                    'client_id' => client_id,
                    'payed' => payed }
    end
    p 'File has been created'
    attribute
  end
end
