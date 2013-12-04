require './lib/amazonsearch.rb'

class SearchesController < ApplicationController
  include AmazonSearch
    respond_to :html, :xml, :json
  
  def create
    @list = List.find(params[:list_id])
    search_options = Hash["Keywords" => params["value"]]
    @search_request = item_search(search_options)
    
    keyword = params[:value] 
    @etsy_response = HTTParty.get("https://openapi.etsy.com/v2/listings/active?includes=Images&limit=10&keywords='#{keyword}'&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}")
  end
end

