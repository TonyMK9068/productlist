module ApplicationHelper

  #convert amount in cents to USD $xx.xx
  def format_product_price(price_in_cents)
    amount = price_in_cents.to_f/100.00
    formatted_usd = "$" + "#{amount}"
  end

  # def check_value_and_assign(value)
  #   if defined?(value)
  #     self = value
  #   else
  #     self = 
  # end
end