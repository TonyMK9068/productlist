require 'amazonsearch'

class SearchesController < ApplicationController
  include AmazonSearch
    respond_to :html, :xml, :json
  
  def create
    @list = List.find(params[:list_id])
    page = params[:page].to_i
    if defined?(page)
      if page > 10
        @page = 1
      else
        @page = page
      end
    else
      @page = 1
    end
    esty_offset = ((@page * 12) - 12)
    @keyword = params[:value]
    encoded_input = URI.encode_www_form_component(@keyword)
    authorize! :manage, @list, message: "You need have created the list to do that"
    @amazon_response = HTTParty.get(AmazonSearch::Request.new.item_search(@keyword, @page))
    @etsy_response = HTTParty.get(AmazonSearch::EtsyRequest.new.search(encoded_input, esty_offset))
  end
end