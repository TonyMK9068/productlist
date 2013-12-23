module SearchesHelper
  
  #refactor
  def format_price(string)
    if string.present? && !string.match(/\A(\$\d{0,3}\.\d{0,2})\z/)
      if string.match(/\A(\d{0,3}\.\d{0,2})\z/)
        string = string.prepend("$")
      else
        string = "Not Available"
      end
    elsif string.present? && string.match(/\A(\$\d{0,3}\.\d{0,2})\z/)
      string
    else
      string = "Not Available"
    end
    string
  end

end