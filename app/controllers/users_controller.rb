class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @lists = @user.lists.all
    @products = @user.products.all
    @friends = @user.friends.all
  end

  def index
    #return lists sorted by rank
    #trending view
  end
end
