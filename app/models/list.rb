class List < ActiveRecord::Base
  include PublicActivity::Common
  
  extend FriendlyId
  friendly_id :title, use: :slugged 
  
  attr_accessible :event, :title, :event_date, :slug
  
  belongs_to :user, inverse_of: :lists
  has_many :products

  validates_presence_of :title
  validates_presence_of :event
  validates_presence_of :event_date
  validate :event_date_is_a_future_date, on: :create

  private

    def event_date_is_a_future_date
      errors.add(:event_date, "Must be a a future date.") if event_date.present? == false || event_date < Date.today
    end
end
