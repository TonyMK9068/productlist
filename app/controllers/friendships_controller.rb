class FriendshipsController < ApplicationController
  
  def create
    friend = User.find_by_email(params[:email])
    unless friend && (friend.id != current_user.id)
      if friend == current_user
        flash[:error] = "Cannot add yourself."
        redirect_to user_path(current_user)
      else
        flash[:error] = "No user with that email."
        redirect_to user_path(current_user)
      end
    else
      @friendship = current_user.friendships.build(:friend_id => friend.id)
      if @friendship.save
        @friendship.create_activity(:create, :recipient => friend, :owner => current_user)
        flash[:info] = "Added friend successfully."
        redirect_to user_path(current_user)
      else 
        flash[:error] = "An error occured while adding new friend."
        redirect_to user_path(current_user)
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
      render root_path
    end
  end

end
