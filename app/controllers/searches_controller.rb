class SearchesController < ApplicationController

  respond_to :html, :xml, :json
  
  def create
    @search = Search.new(params[:search])
    @page = params[:page] ||= 1

    @list = List.find(params[:list_id])
    esty_offset = ((@page * 12) - 12)
    @keyword = params[:search][:keyword]
    encoded_input = URI.encode_www_form_component(@keyword)
    authorize! :manage, @list, message: "You need have created the list to do that"
    @amazon_response = HTTParty.get(GiftShareSearch::AmazonRequest.new.item_search(@keyword, @page))
    @etsy_response = HTTParty.get(GiftShareSearch::EtsyRequest.new.search(encoded_input, esty_offset))
    unless defined?(@amazon_response) && defined?(@etsy_response)
      flash[:error] = "No items found. Try a new search"
      rederect_to :back
    end
  end
end