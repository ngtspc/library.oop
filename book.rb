require_relative 'file_handler'
require_relative 'language'
require_relative 'orders'

class Books < Rating
  include Language
  attr_reader :books, :orders

  def initialize(books = FileHandler.new('books'))
    @books = books
    super()
  end

  def input_check
    print phrases_list[:auchoose_author]
    book_id = gets.chomp.to_s
    located_book = find_book_by_id(book_id)
    until !located_book.nil?
      p "-" * 60
      puts phrases_list[:double_check]
      book_id = gets.chomp.to_s
      located_book = find_book_by_id(book_id)
    end
    book_id
  end

  def find_book_by_id(book_id)
    array_books = books.parse_file
    array_books.find { |book| book['author_id'] == book_id }
  end 

  def get_book_info(located_book)
    p "-" * 60
    puts phrases_list[:book]
    p "Name: #{located_book['name']}"
    p "ID: #{located_book['id']}"
    p "Written date: #{located_book['written_date']}"
    p "Price: #{located_book['price']}"
    puts phrases_list[:confirm_payment]
    p "-" * 60
  end

  def payment_actions
    confirm = gets.chomp
    while confirm != phrases_list[:buy]
      input_check
      get_book_info(located_book)
      confirm = gets.chomp
    end
  end

end

