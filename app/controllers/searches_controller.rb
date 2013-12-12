require './lib/amazonsearch.rb'

class SearchesController < ApplicationController
  include AmazonSearch
    respond_to :html, :xml, :json
  
  def create
    @list = List.find_by_slug(params[:list_id])
    input = params[:value]
    encoded_input = URI.encode_www_form_component(input)

    @amazon_response = HTTParty.get(AmazonSearch::Request.new.item_search(input))

    unless @etsy_response = HTTParty.get("https://openapi.etsy.com/v2/listings/active?includes=Images&limit=10&keywords='#{encoded_input}'&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}")
    	flash[:error] = 'No results. Please try another search'
    	redirect_to @list
    end
  end
end

