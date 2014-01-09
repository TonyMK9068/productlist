module ApplicationHelper

  #convert amount in cents to USD $xx.xx
  def format_product_price(price_in_cents)
    amount = price_in_cents.to_f/100.00
    formatted_usd = "$" + "#{amount}"
  end

  def set_value_or_alt(input)
    if input.nil?
      return "Not available"
    else
      input
    end
  end

  def pluralize_without_count(count, noun, text = nil)
    if count != 0
      count == 1 ? "an #{noun}#{text}" : "#{noun.pluralize}#{text}"
    end
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
end
