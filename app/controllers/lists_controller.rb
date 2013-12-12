class ListsController < ApplicationController
  def index
    @lists = current_user.lists.all
  end

  def new
    @list = List.new
    authorize! :create, List, message: "You need to be signed in to do that"
  end

  def create
    @list = current_user.lists.build(params[:list])
    authorize! :create, @list, message: "You need to be signed in to do that"
    if @list.save
      flash[:alert] = "List created!"
      redirect_to @list
    else
      flash[:error] = "This must be your list to do that"
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
    @products = @list.products.all
  end
  
  def edit
    @list = List.find(params[:id])
    authorize! :manage, @list, message: "This must be your list to do that"
  end
  
  def update
    @list = List.find(params[:id])
    authorize! :manage, @list, message: "This must be your list to do that"
    if @list.update_attributes(params[:list])
      redirect_to @list, notice: "List updated successfully"
    else
      flash[:error] = "This must be your list to do that"
      render user_path(current_user)
    end
  end

  def destroy
    @list = List.find(params[:id])
    authorize! :manage, @list, message: "Not authorized to do that."
    if @list.destroy
      flash[:notice] = "List deleted"
      redirect_to user_path(current_user)
    else
      flash[:error] = "This must be your list to do that"
      redirect_to :back
    end
  end
end
