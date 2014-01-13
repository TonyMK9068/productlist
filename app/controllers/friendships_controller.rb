class FriendshipsController < ApplicationController
  respond_to :html, :js
  
  def create
    @friend = User.find_by_email(params[:email])
    @user = current_user
    authorize! :manage, Friendship, message: "Not authorized"
    if @friend.present?
      if @friend.id != @user.id 
        @friendship = @user.friendships.build(:friend_id => @friend.id)
        if @friendship.save
          @friendship.create_activity(:create, :recipient => @friend, :owner => @user)
          flash[:info] = "Friend added"
        else 
          flash[:error] = "User not found"
        end
      else
        flash[:error] = 'Get some real friends!'
      end
    else
      flash[:error] = 'User not found'
    end

    respond_with(@friend, @friendship) do |f|
      f.html { redirect_to user_path(@user) }
    end
  end

  def destroy
    @user = current_user
    @friendship =  Friendship.find(params[:id])
    @friend_id = User.find @friendship.friend_id
    authorize! :manage, @friendship, message: "Not your friendship to destroy"
    if @friendship.delete
      flash[:info] = "Friend removed successfully"
    else
      flash[:error] ="An error occured while trying to remove the friend"
    end
    respond_with(@friendship) do |f|
      f.html { redirect_to user_path(@user) }
    end
  end
end
