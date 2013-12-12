module AmazonSearch
  
  def set_amazon_defaults
    @accesskey = ENV["AMAZON_KEY"]
    @associate = "gift0bd-20"
    @secret = ENV["AMAZON_SECRET"]
    @timestamp = Time.parse("#{Time.now.utc}").iso8601
    
    @default_values = Hash[
                        "Service" => "AWSECommerceService", 
                         "Timestamp" => @timestamp, 
                         "AWSAccessKeyId" => @accesskey, "AssociateTag" => @associate, 
                         "ContentType" => "text/html",
                        ]
  end

  def combine_defaults_with_operation_values(operation_value)
    set_amazon_defaults
    response_options = { "ResponseGroup" => "Medium, Images", "SearchIndex" => "All" }

    @default_and_operation_value_hash = { "Operation" => operation_value }.merge(response_options).merge(@default_values) 
  end

  # def combine_defaults_with_node_lookup_values(node)
  #   set_amazon_defaults
  #   response_options = Hash[
  #                         "Operation" => "BrowseNodeLookup",
  #                         "ResponseGroup" => "BrowseNodeInfo",
  #                         "BrowseNodeId" => node,
  #                       ]

  #   @default_and_operation_value_hash = response_options.merge(@default_values) 
  # end

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

  def item_search(options = {})
    combine_defaults_with_operation_values("ItemSearch")
    query = @default_and_operation_value_hash.merge(options).sort
    string_to_sign(query)
    create_sig
    @request = URI("http://webservices.amazon.com/onca/xml?" + @url_query + "&" + "Signature=" + @sig)
    @request
  end

  #returns available categories of Amazon store products.
  #options available: BrowserNodeId. Returns ancestors and children of current specified node.
  # def node_lookup(node)
  #   combine_defaults_with_node_lookup_values(node)      
  #   unsorted_query = @default_and_operation_value_hash
  #   sorted_query = unsorted_query.sort
  #   string_to_sign(sorted_query)
  #   create_sig
  #   @request = ("http://webservices.amazon.com/onca/xml?" + @url_query + "&" + "Signature=" + @sig)
  # end
end