class List < ActiveRecord::Base
  attr_accessible :event, :title, :event_date
  #add description
  belongs_to :user, inverse_of: :lists
  has_many :products

  validates :event_date, presence: true, event_date_format: { is: true, message: "Must be a future date." }
  validates_presence_of :title, :event

end
