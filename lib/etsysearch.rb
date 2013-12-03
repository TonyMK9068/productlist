module EtsySearch

  def listing_query_default_values
    @api_key = ENV['ETSY_KEY']
    base_url = "https://openapi.etsy.com/v2"
    uri = "/listings/active" + "?"
    @request_base_and_uri_for_listing = base_url + uri
  end

  # findAllListingActive method
  def request_for_active_listings
    listing_query_default_values
    query_string = URI.encode_www_form("api_key" => ENV['ETSY_KEY'])
    @request_string = URI(@request_base_and_uri_for_listing + query_string)
  end

  def open_etsy_response
    request_for_active_listings
    response = open(@request_string)
  end

  #   def set_user_defaults
  #   @api_key = ENV['mw3bh3ef0flr43aaofo39jki']
  #   base_url = "https://openapi.etsy.com/v2"
  #   uri = "/user/etsystore" + "?"
  #   @request_base_and_uri_for_user = base_url + uri
  # end

  #   def etsy_store_request
  #   set_user_defaults

  #   query_string = URI.encode_www_form("api_key" => ENV['ETSY_KEY'])
  #   @etsy_request_url = URI(@request_base_and_uri_for_user + query_string)
  # end
end