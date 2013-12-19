class User < ActiveRecord::Base 
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :username, :first_name, :last_name
  
  has_many :lists, dependent: :destroy
  has_many :products, :through => :lists
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :searches
  has_many :messages
  
  validates_uniqueness_of :username, allow_blank: :true
  validates_format_of :username, with: /\A([a-zA-Z0-9]{2,16}[-_]?[a-zA-Z0-9]{2,16})\z/, allow_blank: :true
  validates_length_of :username, in: 3..18, allow_blank: true

  validates_format_of :email, with: /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_format_of :first_name, :last_name, with: /\A([^\d\W]+)\z/, allow_blank: :true
  validates_length_of :first_name, :last_name, in: 3..16, allow_blank: true

  after_create :send_confirmation_email

  def has_friend?(user)
    self.friends.all.include?(user) ? true : false
  end

  def display_user_as(title)
    if title == "username"
      self.username.present? ? self.username : self.email
    else
      self.email
    end
  end

  private

    def send_confirmation_email
      UserMailer.signup_confirmation(self).deliver
    end
end
