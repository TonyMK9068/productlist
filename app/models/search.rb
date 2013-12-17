class Search < ActiveRecord::Base
  include GiftShareSearch
  attr_accessible :keyword, :user

  validates_format_of :keyword, with: /\A[a-zA-Z]([^;~@^*]*+)\z/i
  validates_length_of :keyword, max: 100

end

module GiftShareSearch #AmazonSearch
  class AmazonRequest
    def initialize
      @secret = ENV["AMAZON_SECRET"]
      @timestamp = Time.parse("#{Time.now.utc}").iso8601
      @default_values = Hash[
                          "Service" => "AWSECommerceService", 
                           "Timestamp" => @timestamp, 
                           "AWSAccessKeyId" => ENV["AMAZON_KEY"], 
                           "AssociateTag" => ENV["AMAZON_ASSOCIATE"]]
    end
    
    def string_to_sign(input)
      string = ("GET" + "\n" + "webservices.amazon.com" + "\n" + "/onca/xml" + "\n" + input)
    end
    
    def request_sig(query)
      signature = OpenSSL::HMAC::digest(OpenSSL::Digest::Digest.new('sha256'), @secret, string_to_sign(query))
      sig = Base64.encode64(signature).strip
      sig = URI.encode_www_form_component(sig)
    end

    def item_search(keyword_input, item_page = 1)
      search_options = Hash["ResponseGroup" => "Medium, Images", "SearchIndex" => "All", "Operation" => "ItemSearch", "Keywords" => keyword_input, "ItemPage" => item_page]
      url_query = (URI.encode_www_form((search_options.merge(@default_values)).sort)).gsub!('+', '%20')
      request = ("http://webservices.amazon.com/onca/xml?" + url_query + "&" + "Signature=" + "#{sig = request_sig(url_query)}")
    end
  end

  class EtsyRequest

    def search(keyword, page = 1)
      request_url = "https://openapi.etsy.com/v2/listings/active?includes=Images&limit=12&offset=#{page}&keywords=#{keyword}&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}"
    end
  end

end