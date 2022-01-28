module Language
  @@language = :en

  LANGUAGES = %i[en ru].freeze

  COMMANDS = %w[ buy_book profit top_books top_authors top_clients show_books show_authors show_clients
                 show_orders add_book add_author add_client add_order exit ].freeze

  TEXTS = {
    en: {
      get_list: 'Here are the list of commands you can use here:',
      greeting: 'Welcome to our books shop',
      info: 'Please enter your info',
      enter_name: 'Enter first name: ',
      enter_surname: 'Enter last name: ',
      enter_address: 'Your address: ',
      choose_author: 'Please choose the number of the author: ',
      double_check: 'Please double-check your choice',
      book_info: 'Here is your book',
      confirm_payment: 'Type "Buy" to purchase the book or any text to choose another author',
      new_client: 'Are you a new client in our shop?',
      enter_details: 'Please enter your name and surname',
      payment_accepted: 'Thank you for the payment',
      profit: 'Total profit of the shop: ',
      invalid_command: 'Please choose a comand from the list',
      yes: 'yes',
      no: 'no',
      command: 'Command: ',
      buy: 'buy',
      key_id: 'Please enter id: ',
      key_name: 'Please enter name: ',
      key_written_date: 'Please enter date of writing: ',
      key_created_at: 'Please enter date of creation: ',
      key_updated_at: 'Please enter updated_at: ',
      key_author_id: 'Please enter author_id: ',
      key_price: 'Please enter price: ',
      key_book_id: 'Please enter book id: ',
      key_address: 'Please enter address: ',
      key_client_id: 'Please enter client_id: ',
      key_payed: 'Please enter payed: ',
      file_created: 'File has been created'
    },
    ru: {
      get_list: 'Вы можете использовать список команд предоставленный ниже:',
      greeting: 'Добро пожаловать в наш книжный магазин',
      info: 'Пожалуйста, заполните далее поля для создание вашей анкеты',
      enter_name: 'Введите имя: ',
      enter_surname: 'Введите фамилию: ',
      enter_address: 'Ваш адрес проживания: ',
      choose_author: 'Пожалуйста, выберите номер автора: ',
      double_check: 'Пожалуйста, перепроверьте ваш выбор',
      book_info: 'По данному автору доступна следующая книга:',
      confirm_payment: 'Пожалуйста введите "Купить" чтобы купить книгу или любой другой символ чтобы выбрать другого автора',
      new_client: 'Вы впервые покупаете у нас книгу?',
      enter_details: 'Пожалуйста, введите ваше имя и фамилию',
      payment_accepted: 'Платёж прошёл успешно! Спасибо за покупку!',
      profit: 'Общая прибыль магазина составляет ',
      invalid_command: 'Пожалуйста, выберите команду из списка',
      yes: 'да',
      no: 'нет',
      command: 'Сценарий: ',
      buy: 'купить',
      key_id: 'Пожалуйста ведите id: ',
      key_name: 'Пожалуйста введите имя: ',
      key_written_date: 'Пожаоуйста введите дату написания: ',
      key_created_at: 'Пожалуйста введите дату создания: ',
      key_updated_at: 'Пожалуйста введите дату обновления: ',
      key_author_id: 'Пожалуйста введите id автора: ',
      key_price: 'Пожалуйста введите стоимость: ',
      key_book_id: 'Пожалуйста введите id книги: ',
      key_address: 'Пожалуйста введите адрес: ',
      key_client_id: 'Пожалуйста введите id клиента: ',
      key_payed: 'Пожалуйста укажите сумму оплаты: ',
      file_created: 'Файл был создан'
    }
  }.freeze

  def choose_version
    puts 'Please enter "en" for english language/Пожалуйста введите "ru" для русского языка:'
    @@language = gets.chomp.to_sym
    unless LANGUAGES.include?(@@language)
      puts 'Please choose ":en" or ":ru" '
      @@language = gets.chomp.to_sym
    end
    @@language
  end

  def phrases_list
    TEXTS[@@language]
  end

  def greeting
    puts phrases_list[:greeting]
  end

  def commands
    puts phrases_list[:get_list]
    COMMANDS.each do |name|
      p name
    end
  end
end
