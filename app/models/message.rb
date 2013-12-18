class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :recipient

  validates_length_of :recipient, in: 0..30
  validates_format_of :recipient, :with => /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :recipient
end
