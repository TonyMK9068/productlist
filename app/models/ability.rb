class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      
      if user.createad_at
        can :manage, List, user_id: user.id
        can :manage, Friendship, user_id: user.id
      else
        can :read, :all
      end
  end
end
