module ObjectCreator
  def create_file(file_name)
    case file_name
    when 'book'
      p phrases_list[:key_id]
      id = gets.chomp
      p phrases_list[:key_name]
      name = gets.chomp
      p phrases_list[:key_written_date]
      written_date = gets.chomp
      p phrases_list[:key_created_at]
      created_at = gets.chomp
      p phrases_list[:key_updated_at]
      updated_at = gets.chomp
      p phrases_list[:key_author_id]
      author_id = gets.chomp
      p phrases_list[:key_price]
      price = gets.chomp
      attribute = { 
        'id' => id,
        'name' => name,
        'written_date' => written_date,
        'created_at' => created_at,
        'updated_at' => updated_at,
        'author_id' => author_id,
        'price' => price 
      }
    when 'author'
      p phrases_list[:enter_name]
      first_name = gets.chomp
      p phrases_list[:enter_surname]
      last_name = gets.chomp
      p phrases_list[:book_id]
      book_id = gets.chomp
      attribute = { '
        'first_name' => first_name,
        'last_name' => last_name,
        'book_id' => book_id 
      }
    when 'client'
      p phrases_list[:id]
      id = gets.chomp
      p phrases_list[:enter_name]
      first_name = gets.chomp
      p phrases_list[:enter_surname]
      last_name = gets.chomp
      p phrases_list[:address]
      address = gets.chomp
      attribute = { 
        'id' => id.to_i,
        'first_name' => first_name,
        'last_name' => last_name,
        'address' => address 
      }
    when 'order'
      p phrases_list[key_book_id]
      book_id = gets.chomp
      p phrases_list[:key_created_at]
      created_at = gets.chomp
      p phrases_list[:client_id]
      client_id = gets.chomp
      p phrases_list[:key_payed]
      payed = gets.chomp
      attribute = { 
        'book_id' => book_id,
        'created_at' => created_at,
        'client_id' => client_id,
        'payed' => payed 
      }
    end
    p phrases_list[:file_created]
    attribute
  end
end
