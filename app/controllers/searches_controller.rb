class SearchesController < ApplicationController

  respond_to :html, :xml, :json
  
  def create
    @search = Search.new(params[:search])

    @list = List.find(params[:list_id])
    @page = @page ||= 1

    esty_offset = ((@page * 12) - 12)

    encoded_input = URI.encode_www_form_component(@keyword)
    authorize! :manage, @list, message: "You need have created the list to do that"
    @amazon_response = HTTParty.get(GiftShareSearch::AmazonRequest.new.item_search(@keyword, @page))
    @etsy_response = HTTParty.get(GiftShareSearch::EtsyRequest.new.search(encoded_input, esty_offset))
  end
end