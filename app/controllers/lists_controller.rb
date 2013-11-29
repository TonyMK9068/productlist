require './lib/etsysearch.rb'

class ListsController < ApplicationController

  include EtsySearch
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
#    @node_list = node_lookup("195208011")

  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
  end

end
