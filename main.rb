# frozen_string_literal: true
# # frozen_string_literal: true

# require_relative 'library'

# rating_args = { orders: (FileHandler.new('orders').parse_file),
#                 books: (FileHandler.new('books').parse_file),
#                 authors: (FileHandler.new('authors').parse_file),
#                 clients: (FileHandler.new('clients').parse_file) }

# entities = { books: Book.new(rating_args[:books]),
#              authors: Author.new(rating_args[:authors]),
#              clients: Client.new(rating_args[:clients]),
#              orders: Order.new(rating_args[:orders]),
#              rating: Rating.new(rating_args[:orders],
#                                 rating_args[:books],
#                                 rating_args[:authors],
#                                 rating_args[:clients]) }

# library = Library.new(entities)
# library.run
