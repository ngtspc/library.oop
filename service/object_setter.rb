module ObjectSetter
  
  def create_file(attributes)
    result = {}
    attributes.each do |field|
      p "Please enter #{field}"
      result[field] = gets.chomp
      result
    end
    p phrases_list[:file_created]
    result
  end
end
