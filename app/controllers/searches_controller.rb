class SearchesController < ApplicationController
  before_filter :set_page
  
  respond_to :html, :xml, :json
  
  def create
    @search = current_user.searches.build(params[:search].merge(list_id: @list.id))
    @search.page = 1 

    authorize! :create, Search, message: "You need have created the list to do that"
    if @search.save
      redirect_to [@list, @search]
    else
      flash[:error] = "An error occurred while processing your request."
      render action: :show, controller: :lists
    end
  end

  def show
    @search = Search.find(params[:id])
    @etsy_results = @search.etsy_response_arrays
    @amazon_results = @search.amazon_response_arrays
    
    authorize! :manage, @search, message: "You need have created the list to do that"
  end

  def next
    @search = Search.find(params[:id])
    authorize! :manage, @search, message: "You need have created the list to do that"
    if @search.update_attributes(:page => @search.page += 1)
      redirect_to list_search_path(list_id: @list, id: @search.id)
    else
      flash[:error] = "Sorry, an error occured while handling your request."
      render :back
    end
  end

  def previous
    @search = Search.find(params[:id])
    authorize! :manage, @search, message: "You need have created the list to do that"
    if @search.update_attributes(:page => @search.page -= 1)
      redirect_to list_search_path(list_id: @list, id: @search.id)
    else
      flash[:error] = "Sorry, an error occured while handling your request."
      render :back
    end
  end

  protected
  def set_page
    @list = List.find(params[:list_id])
  end
end