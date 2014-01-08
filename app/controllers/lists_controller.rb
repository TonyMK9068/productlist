class ListsController < ApplicationController
  
  def new
    @list = List.new
    authorize! :create, List, message: "You need to be signed in to do that"
  end

  def create
    @list = current_user.lists.build(params[:list])
    authorize! :create, @list, message: "You need to be signed in to do that"
    if @list.save
      @list.create_activity(:create, :owner => current_user)
      flash[:alert] = "List created!"
      redirect_to @list
    else
      flash[:error] = "Error occured creating your list"
      render controller: 'users', action: :show
    end
  end

  def show
    @list = List.find(params[:id])
    @products = @list.products.all
    @search = Search.new
    authorize! :read, @list, message: "You need to be signed in to do that"
  end
  
  def edit
    @list = List.find(params[:id])
    authorize! :update, @list, message: "This must be your list to do that"
  end
  
  def update
    @list = List.find(params[:id])
    authorize! :update, @list, message: "This must be your list to do that"
    if @list.update_attributes(params[:list])
      flash[:notice] = "List updated successfully"
      redirect_to @list
    else
      flash[:error] = "This must be your list to do that"
      render controller: 'users', action: :show
    end
  end

  def destroy
    @list = List.find(params[:id])
    authorize! :update, @list, message: "Not authorized to do that."
    if @list.destroy
      flash[:notice] = "List deleted"
      redirect_to user_path(current_user)
    else
      flash[:error] = "This must be your list to do that"
      redirect_to :back
    end
  end
end
