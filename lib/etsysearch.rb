# Listings are Esty Items for sale
# Each listing is assocciated with a User and a Shop
# Users own Shops
# findAllListingActive returns all active Listings on Etsy, paginated by date
# default returned per callis 25, max 100. 
# limit is how many records per page, while offset is for pagination, 

module EtsySearch

  require 'openssl'
  require 'uri'
  require 'time'
  require "base64" 

  def set_etsy_defaults
    @api_key = 'yw44xdyjoypejd6vaiuopjbr'
    base_url = "https://openapi.etsy.com/v2"
    uri = "/listings/active" + "?"
    @request_base_and_uri = base_url + uri
  end

  # findAllListingActive method
  def return_listings(user_input)
    @request_base_and_uri = set_etsy_defaults
    @user_input = user_input
    #@offset = offset
    query_string = URI.encode_www_form("keywords" => @user_input, "sort_on" => "score", "api_key" => @api_key)
    @request_url = @request_base_and_uri + query_string
  end
end