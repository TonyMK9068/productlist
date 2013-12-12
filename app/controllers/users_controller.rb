class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @lists = @user.lists.all
    @products = @user.products.all
    @friends = @user.friends.all
  end

  # def index
  #   user leader board would go here
  # end
end
