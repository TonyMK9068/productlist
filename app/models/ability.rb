class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      
      if user.created_at
        can :manage, List, user_id: user.id
        can :manage, Product, user.lists.all.include?(:list_id)
        can :manage, Friendship, user_id: user.id
      else
        can :read, :all
      end
  end
end
