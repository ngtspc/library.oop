module Language

  @@language = :en

  LANGUAGES = [:en, :ru]
  
  COMMANDS = %w[get_list buy_book profit top_books top_authors top_clients show_books show_authors show_clients show_orders exit]

  TEXTS = {
    en: {
      get_list: 'Here are the list of commands you can use here:',
      greeting: 'Welcome to our books shop',
      info:  'Please enter your info',
      enter_name: 'Your first name: ',
      enter_surname: 'Your last name: ',
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
      yes: 'Yes',
      no: 'No',
      command: 'Command: ',
      buy: 'Buy'
    },
    ru: {
      get_list: 'Вы можете использовать список команд предоставленный ниже:',
      greeting: 'Добро пожаловать в наш книжный магазин',
      info: 'Пожалуйста, заполните далее поля для создание вашей анкеты',
      enter_name: 'Ваше имя: ',
      enter_surname: 'Ваша фамилия: ',
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
      yes: 'Да',
      no: 'Нет',
      command: 'Сценарий: ',
      buy: 'Купить'
    }
  }

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