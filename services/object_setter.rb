module ObjectSetter
  
  def new_object(attributes)
    result = {}
    attributes.each do |field|
      p " #{phrases_list[:type]}#{field}"
      result[field] = gets.chomp
      result
    end
    p phrases_list[:file_created]
    result
  end
end
