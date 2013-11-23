class EventDateFormatValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    
    selected_time = value.strftime("%-d/%-m/%Y").split("/")
    current_time = Time.now.strftime("%-d/%-m/%Y").split("/")

    if current_time[1] < selected_time[1]
      true
    elsif current_time[1] == selected_time[1] && current_time[2] < selected_time[2]
      true    
    else
      object.errors[attribute] << options[:message]
    end
  end
  
end