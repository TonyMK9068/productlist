class SearchesController < ApplicationController
  before_filer :set_page
  
  respond_to :html, :xml, :json
  
  def create
    @search = current_user.searches.build(params[:search])

    authorize! :manage, @list, message: "You need have created the list to do that"

    if defined?(@amazon_response) && defined?(@etsy_response)
      flash[:error] = "No items found. Try a new search"
      redirect_to [@list, @search]
    else
      render action: :show, controller: :lists
    end
  end

  def show
    @search = Search.find(params[:id])
    authorize! :manage, @list, message: "You need have created the list to do that"
  end

  def next_page
    @search = Search.find(params[:id])
    authorize! :manage, @list, message: "You need have created the list to do that"
    if @search.update_attributes(:page => @search.page + 1)
      redirect_to [@list, @search]
    else
      flash[:error] = "Sorry, an error occured while handling your request."
      render action: :show, controller: :lists 
    end
  end

  def previous_page
    @search = Search.find(params[:id])
    authorize! :manage, @list, message: "You need have created the list to do that"
    if @search.update_attributes(:page => @search.page - 1)
      redirect_to [@list, @search]
    else
      flash[:error] = "Sorry, an error occured while handling your request."
      render action: :show, controller: :lists 
    end
  end

  private

  def set_page
    @list = List.find(params[:list_id])
  end
end