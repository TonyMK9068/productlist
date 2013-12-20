module FriendshipsHelper

  def count_lists_by(friend)
    friend.lists.all.count
  end
  
end
