class Search < ActiveRecord::Base

  attr_accessible :keyword, :page, :list_id
  belongs_to :user
  belongs_to :list
  
  validates_format_of :keyword, with: /\A[a-zA-Z]([^;~@^*]*+)\z/i
  validates_length_of :keyword, maximum: 100
  validates :page, numericality: true
  validates_presence_of :user_id
  validates_presence_of :list_id
  validate :ownership_of_list
  
  def amazon_response
    HTTParty.get(AmazonRequest.new.item_search(self.keyword, self.page))
  end

  def etsy_response
    HTTParty.get(EtsyRequest.new.search(self.keyword, self.page))
  end
  
  def commission_response
    CommissionRequest.send_request(self.keyword, self.page)
  end
  
  def product_keys
    %w(product_number image_url price name link category store).map! { |value| value.to_sym }
  end
  
  def amazon_array_of_arrays
    amazon_response.access("ItemSearchResponse.Items.Item").collect do |re|
        [
          re.access("ASIN"),
          re.access("MediumImage.URL"),
          re.access("ItemAttributes.ListPrice.FormattedPrice"),
          re.access("ItemAttributes.Title"),
          re.access("DetailPageURL"),
          re.access("ItemAttributes.ProductGroup"),
          "Amazon.com",
        ]
    end
  end
  
  def etsy_array_of_array
    etsy_response.access("results").collect do |re|
      [
        re.access("listing_id"),
        re.access("Images.0.url_170x135"),
        re.access("price"), #string, decimal precision 2, not formatted
        re.access("title"),
        re.access("url"),
        re.access("category_path").last,
        "Etsy.com"
        ]
    end
  end
  
  def commission_array_of_array
    commission_response.each do |response|
      [
        response.manufacturer_sku,
        response.image_url,
        response.price,
        response.name,
        response.advertiser_name,
        response.buy_url,
        response.advertiser_category,
        response.advertiser_name
      ]
    end
  end

  def commission_response_arrays
    if commission_array_of_array.each { |i| false if i.blank? } == true
      commission_array_of_array.collect do |array|
        Hash[product_keys.zip array]
      end
    else
      false
    end
  end
  
  def amazon_response_arrays
    if amazon_array_of_arrays.each { |i| false if i.blank? } == true
      amazon_array_of_arrays.collect do |array|
        Hash[product_keys.zip array]
      end
    else
      false
    end
  end

  def etsy_response_arrays
    if amazon_array_of_arrays.each { |i| false if i.blank? } == true
      etsy_array_of_array.collect do |array|
        Hash[product_keys.zip array]
      end
    else
      false
    end
  end
  
  def combined_results
    if etsy_response_arrays
      if amazon_response_arrays
        if commission_response_arrays
          return etsy_response_arrays + amazon_response_arrays + commission_response_arrays
        else
          return etsy_response_arrays + amazon_response_arrays
        end
      else
        if commission_response_arrays
          return etsy_response_arrays + commission_response_arrays
        else
          return etsy_response_arrays
        end
      end
    else
      if amazon_response_arrays
        if commission_response_arrays
          return amazon_response_arrays + commission_response_arrays
        else
          return amazon_response_arrays
        end
      else 
        if commission_response_arrays
        return results = commission_response_arrays
        else
          return false
        end
      end
    end
  end

  def etsy_count
    etsy_response.body.access("count")
  end
  
  protected 

  def ownership_of_list
    errors.add(:list_id, "Not authorized to perform searches for this list") if user.lists.include? List.find(list_id) == false
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
    request = ("https://webservices.amazon.com/onca/xml?" + url_query + "&" + "Signature=" + "#{sig = request_sig(url_query)}")
  end
end

class EtsyRequest

  def search(keyword, page = 1)
    page_offset = (page * 12) - 12
    encoded_keyword = URI.encode_www_form_component keyword
    request_url = "https://openapi.etsy.com/v2/listings/active?includes=Images&limit=12&offset=#{page_offset}&keywords=#{encoded_keyword}&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}"
  end
end

class CommissionRequest
  COMM_JUNC_KEY = ENV['COMM_JUNC_KEY']
  WEBSITE_ID = ENV['WEB_CODE']
  
  def self.send_request(keyword, page = 1)
    cj = CommissionJunction.new(COMM_JUNC_KEY, WEBSITE_ID)
    encoded_keyword = URI.encode_www_form_component keyword
    cj.product_search('keywords' => encoded_keyword, 'advertiser-ids' => 'joined', 'serviceable-area' => 'us', 'currency' => 'usd', 'records-per-page' => '21', 'page-number' => page)
  end
end