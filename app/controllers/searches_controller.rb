require 'amazonsearch'

class SearchesController < ApplicationController
  include AmazonSearch
    respond_to :html, :xml, :json
  
  def create
    @list = List.find_by_slug(params[:list_id])

    input = params[:value]
    encoded_input = URI.encode_www_form_component(input)
    authorize! :manage, @list, message: "You need have created the list to do that"

    if  !(@amazon_response = HTTParty.get(AmazonSearch::Request.new.item_search(input))) || !(@etsy_response = HTTParty.get(AmazonSearch::EtsyRequest::search(encoded_input)))
    	flash[:error] = 'No results. Please try another search'
    	redirect_to @list
    end
  end
end