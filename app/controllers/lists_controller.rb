require './lib/amazonsearch'

class ListsController < ApplicationController

  include AmazonSearch
    respond_to :html, :xml, :json

  def index
    @lists = current_user.lists.all
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(params[:list])
    if @list.save
      flash[:alert] = "List created!"
      redirect_to @list
    else
      flash[:error] = "An error occured while saving your list :'("
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
    @products = @list.products.all
    @node_list = node_lookup("1036682")

  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
  end

end
