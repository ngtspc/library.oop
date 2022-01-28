module LibraryHelper
  def command_converter(input)
    input = input.split('-')
    input.delete_at(0) if input.size > 1
    input.join('')
  end
end
