class Friendship < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  attr_accessible :friend_id, :user_id
  
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_uniqueness_of :friend_id, :scope => :user_id
  validates_presence_of :friend_id, :user_id
end
