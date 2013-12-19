class UsersController < ApplicationController

  def show
    @profile_viewer = current_user
    @profile_owner = User.find(params[:id])
    @lists = @profile_owner.lists.all
    @products = @profile_owner.products.all
    @friends = @profile_owner.friends.all
    
    authorize! :read, User, message: "Create an account to view profiles"
  end
end
