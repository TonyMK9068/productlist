require './lib/amazonsearch'

class SearchesController < ApplicationController
  include AmazonSearch
    respond_to :html, :xml, :json
  
  def create
    @list = List.find(params[:list_id])
    @search_options = Hash[params["option"] => params["value"]]
    @search_request = item_search(@search_options)
  end

end
