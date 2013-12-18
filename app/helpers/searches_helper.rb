module SearchesHelper
  def amazon_array_of_arrays
    @amazon_response.access("ItemSearchResponse.Items.Item").collect do |re|
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
 
  def product_keys
    %w(product_number image_url price name link category store).map! { |value| value.to_sym }
  end
  
  def amazon_response_arrays
    amazon_array_of_arrays.collect do |array|
      Hash[product_keys.zip array]
    end
  end

  def etsy_array_of_array
    @etsy_response.access("results").collect do |re|
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

  def etsy_response_arrays
    etsy_array_of_array.collect do |array|
      Hash[product_keys.zip array]
    end
  end

  def etsy_count
    @etsy_response.body.access("count")
  end

end