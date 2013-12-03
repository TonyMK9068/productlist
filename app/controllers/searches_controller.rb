require './lib/etsysearch.rb'
require './lib/amazonsearch.rb'

class SearchesController < ApplicationController
  include EtsySearch, AmazonSearch

    respond_to :html, :xml, :json
  
  def create
    @list = List.find(params[:list_id])
    user_input = params["value"]
    # @etsy_response = open_etsy_response

    @search_options = Hash["Keywords" => user_input]
    @search_request = item_search(@search_options)

  end

end
