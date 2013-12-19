class Friendship < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :friend_id, :user_id
  
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_uniqueness_of :friend_id, :scope => :user_id
  validates_presence_of :friend_id, :user_id
  validate :cannot_add_self

  protected

  def cannot_add_self
    errors.add(:friend_id, "Get some real friends!") unless user_id != friend_id
  end
end
