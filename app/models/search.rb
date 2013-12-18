class Search < ActiveRecord::Base

  attr_accessible :keyword, :user_id, :page, :list_id
  belongs_to :user
  belongs_to :list
  
  validates_format_of :keyword, with: /\A[a-zA-Z]([^;~@^*]*+)\z/i
  validates_length_of :keyword, maximum: 100
  validates :page, numericality: true
  validates_presence_of :user_id

  def amazon_response
    HTTParty.get(AmazonRequest.new.item_search(self.keyword, self.page))
  end

  def etsy_response
    HTTParty.get(EtsyRequest.new.search(self.keyword, self.page))
  end
end

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
    page_offset = (page * 12) - 12
    encoded_keyword = URI.encode_www_form_component keyword
    request_url = "https://openapi.etsy.com/v2/listings/active?includes=Images&limit=12&offset=#{page_offset}&keywords=#{encoded_keyword}&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}"
  end
end

