require './lib/amazonsearch.rb'

class SearchesController < ApplicationController
  include AmazonSearch
    respond_to :html, :xml, :json
  
  def create
    @list = List.find_by_slug(params[:list_id])
    search_options = Hash["Keywords" => params["value"]]
    @search_request = item_search(search_options)
    
    search_input = params[:value]
    keyword_value = URI.encode_www_form_component(search_input)
    unless @etsy_response = HTTParty.get("https://openapi.etsy.com/v2/listings/active?includes=Images&limit=10&keywords='#{keyword_value}'&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}")
    	flash[:error] = 'No results. Please try another search'
    	redirect_to @list
    end
  end
end

