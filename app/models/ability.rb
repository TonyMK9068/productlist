class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
      
    if user.created_at
      can :read, User
      can :manage, User, id: user.id
      can :manage, List, user_id: user.id
      
      user.lists.all.each do |list|
        can :manage, Product, list_id: list.id
      end

      can :manage, Friendship, user_id: user.id
      can :manage, Search, user_id: user.id
      can :create, Message, user_id: user.id
    end
    can :read, List
    can :read, Product
  end
end
