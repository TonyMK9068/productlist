class ListsController < ApplicationController
  def index
    @lists = current_user.lists.all
  end

  def new
    @list = List.new
    authorize! :create, @list, message: "You need be signed in to do that"
  end

  def create
    @list = current_user.lists.build(params[:list])
    authorize! :create, @list, message: "You need be signed in to do that"
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
  end
  
  def edit
    @list = List.find(params[:id])
    authorize! :manage, @list, message: "You must have created the list to do that"
  end
  
  def update
  end

end
