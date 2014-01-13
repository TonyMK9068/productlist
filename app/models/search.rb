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
    test = CommissionRequest.new.send_request(self.keyword, self.page)
    test
  end
  
  def product_keys
    %w(product_number image_url price name link category store).map! { |value| value.to_sym }
  end
  
  def amazon_array_of_arrays
    response = amazon_response.access("ItemSearchResponse.Items.Item").collect do |re|
        [
          re.access("ASIN"),
          re.access("LargeImage.URL") || re.access("MediumImage.URL") || re.access("SmallImage.URL") || '/568.png',
          re.access("ItemAttributes.ListPrice.FormattedPrice"),
          re.access("ItemAttributes.Title"),
          re.access("DetailPageURL"),
          re.access("ItemAttributes.ProductGroup"),
          "Amazon.com"
        ]
      end
    response = response.collect do |array|      
      array.delete_if do |x|
       x == '' || x == nil
      end
    end
    response
  end
  
  def etsy_array_of_arrays
    if self.etsy_count > 0
      response = etsy_response.access("results").collect do |re|
        [
          re.access("listing_id"),
          re.access("Images.0.url_570xN") || re.access("Images.0.url_170x135"),
          re.access("price"), 
          re.access("title"),
          re.access("url"),
          re.access("category_path").last,
          "Etsy.com"
          ]
      end
    else
      false
    end
  end
  
  def commission_array_of_arrays
    if commission_response
      response = commission_response.collect do |response|
        [
          response.ad_id || '',
          response.image_url || '',
          response.price.to_s,
          response.name,
          response.buy_url || '',
          response.advertiser_category || '',
          response.advertiser_name || ''
        ]
      end
    
      response = response.collect do |array|      
        array.delete_if do |x|
         x == '' || x == nil
        end
      end
      response
    else
      false
    end
  end

  def commission_response_arrays
    if commission_array_of_arrays
      commission_array_of_arrays.collect do |array|
        Hash[product_keys.zip array]
      end
    end
  end
  
  def amazon_response_arrays
    if amazon_array_of_arrays
      amazon_array_of_arrays.collect do |array|
        Hash[product_keys.zip array]
      end
    end
  end

  def etsy_response_arrays
    if etsy_array_of_arrays
      etsy_array_of_arrays.collect do |array|
        Hash[product_keys.zip array]
      end
    end
  end
  
  def combined_results
     results = [etsy_response_arrays, amazon_response_arrays, commission_response_arrays]
     results.delete_if { |x| x.blank? }
     count = results.length
     if count > 0
       results = results.inject{ |sum, x| sum + x }
     else
       false
     end
  end

  def etsy_count
    etsy_response.access("count")
  end
  
  def amazon_count
    amazon_response.access("ItemSearchResponse.Items.Request.TotalResults")
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
  def send_request(keyword, page = 1)
    cj = CommissionJunction.new('009f1a5bc060d7c0b543f227e0de2fb1d957ac3e54fd1f5dcbfd47d3a84e5a59591d449e2f93edfcd5b26a615caad253d76dabb5e88194ba6d939cd1ac7a5dc193/19d9967eb33d5aba18c80762a9b6e616820022407cbfd3e588c95ac245b8b83b5708a20722eb4cb143bb578d74947cfb82c03de34072b057b92c6238b37b0bc1', '7374417')
    encoded_keyword = keyword.gsub(' ', ' +')
    cj.product_search('keywords' => encoded_keyword, 'advertiser-ids' => 'joined', 'serviceable-area' => 'us', 'currency' => 'usd', 'records-per-page' => '20', 'page-number' => page)
  end
end