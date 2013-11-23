class ListsController < ApplicationController
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
  end
  
  def edit
  end
  
  def update
  end

end
