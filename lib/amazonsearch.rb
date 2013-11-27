module AmazonSearch

require 'openssl'
require 'uri'
require 'time'
require "base64" 
  

  def set_defaults
    @accesskey = "AKIAJZGGOUTXFENABOFQ"
    @associate = "giftshare-20"
    @secret ="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"
    @timestamp = Time.parse("#{Time.now.utc}").iso8601
    @default_values = Hash["Service" => "AWSECommerceService", "Timestamp" => @timestamp, 
                          "AWSAccessKeyId" => @accesskey, "AssociateTag" => @associate, 
                          "ContentType" => "text/html"]
  end

  def combine_defaults_with_operation_values(operation_value)
    set_defaults
    response_options = Hash["ResponseGroup" => "Small, Images", "SearchIndex" => "All"]
    @default_and_operation_value_hash = Hash["Operation" => operation_value].merge(response_options).merge(@default_values) 
  end

  def combine_defaults_with_node_lookup_values(node)
    set_defaults
    response_options = Hash["Operation" => "BrowseNodeLookup", "ResponseGroup" => "BrowseNodeInfo", "BrowseNodeId" => "1036592"]
    @default_and_operation_value_hash = response_options.merge(@default_values) 
  end

  def string_to_sign(query)
    @query = query
    string = URI.encode_www_form(@query)
    @url_query = string.gsub('+', '%20')
    @url_string_for_sig = ("GET" + "\n" + "webservices.amazon.com" + "\n" + "/onca/xml" + "\n" + @url_query)
  end

  def create_sig
    signature = OpenSSL::HMAC::digest(OpenSSL::Digest::Digest.new('sha256'), @secret, @url_string_for_sig)
    sig = Base64.encode64(signature).strip
    @sig = URI.encode_www_form_component(sig)
  end

  #options must be present and can take values of "Keywords" or "Title"
  def item_search(options = {})
    combine_defaults_with_operation_values("ItemSearch")
    unsorted_query = @default_and_operation_value_hash.merge(options)
    sorted_query = unsorted_query.sort
    string_to_sign(sorted_query)
    create_sig
    @request = URI("http://webservices.amazon.com/onca/xml?" + @url_query + "&" + "Signature=" + @sig)
    @request
  end

  #returns available categories of Amazon store products.
  #options available: BrowserNodeId. Returns ancestors and children of current specified node.
  def node_lookup(node)
    combine_defaults_with_node_lookup_values(node)      
    unsorted_query = @default_and_operation_value_hash
    sorted_query = unsorted_query.sort
    string_to_sign(sorted_query)
    create_sig
    @request = ("http://webservices.amazon.com/onca/xml?" + @url_query + "&" + "Signature=" + @sig)
  end

  def us_nodes
    nodes = ["1036592", "2619525011", "2617941011", "15690151", "165796011", "11055981", 
            "1000", "301668", "4991425011", "195208011", "2625373011", "493964", "3580501", 
            "16310101", "3760931", "285080", "228239", "3880591", "133141011", "1063498", 
            "2972638011", "599872", "10304191", "2350149011", "195211011", "301668", 
            11091801, 1084128, "1063498", "493964", "1063498", "493964", "409488", "3375251", 
            468240, 493964, 404272, 130, "493964", "377110011", "508494", "13900851"]
  end
end