class List < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged 
  
  attr_accessible :event, :title, :event_date
  
  belongs_to :user, inverse_of: :lists
  has_many :products

  validates_presence_of :title, :event, :event_date
  validate :event_date_is_a_future_date

  private

    def event_date_is_a_future_date
      errors.add(:event_date, "Must be a a future date.") if event_date < Date.today
    end
end
