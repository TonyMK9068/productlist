class FriendshipsController < ApplicationController
  
  def create
    @friend = User.find_by_email(params[:email])
    @user = current_user
    if @friend.present? && @friend.id != @user.id
      @friendship = @user.friendships.build(:friend_id => @friend.id)
      if @friendship.save
        @friendship.create_activity(:create, :recipient => @friend, :owner => @user)
        flash[:info] = "Added friend"
        redirect_to user_path(@user)
      else 
        flash[:error] = "An error occured while adding new friend."
        render 'welcome/index'
      end
    else
      if @friend.present? && @friend.id == @user.id
        flash[:error] = "Cannot add yourself."
        render 'welcome/index'
      else
        flash[:error] = "No user with that email."
        render 'welcome/index'
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:id])
    if @friendship.delete
      flash[:info] = "Friend removed successfully."
      redirect_to :back
    else
      flash[:error] ="An error occured while trying to remove the friend."
      render 'welcome/index'
    end
  end

end
