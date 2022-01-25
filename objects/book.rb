# frozen_string_literal: true

require_relative '../service/file_handler'
require_relative '../service/language'
require 'date'
require 'time'

# Description/Explanation of Book class
class Book
  include Language
  attr_reader :books

  def initialize(books)
    @books = converted_file(books)
    @book = {}
    @choice = ''
  end

  def wrong_input_check
    print phrases_list[:choose_author]
    @choice = gets.chomp.to_i
    @book = load_book
    until @book
      p phrases_list[:double_check]
      @choice = gets.chomp.to_i
      @book = load_book
    end
    @book
  end

  def load_book
    @books.find { |book| book['author_id'] == @choice }
  end

  def book_info
    puts phrases_list[:book]
    p "Name: #{@book['name']}"
    p "ID: #{@book['id']}"
    p "Written date: #{@book['written_date']}"
    p "Price: #{@book['price']}"
    puts phrases_list[:confirm_payment]
  end

  def payment_actions
    @confirm = gets.chomp
    while @confirm != phrases_list[:buy]
      wrong_input_check
      book_info
      @confirm = gets.chomp
    end
  end

  def converted_file(books)
    books.each do |hash|
      hash['id'] = hash['id'].to_i
      hash['written_date'] = DateTime.parse(hash['written_date'])
      hash['created_at'] = DateTime.parse(hash['created_at'])
      hash['update_at'] = DateTime.parse(hash['updated_at'])
      hash['author_id'] = hash['author_id'].to_i
      hash['price'] = hash['price'].to_i
    end
  end
end
