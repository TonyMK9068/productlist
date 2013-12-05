class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :username, :first_name, :last_name
  has_many :lists
  has_many :products, :through => :lists

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_uniqueness_of :username, :allow_nil => true
  validates_format_of :username, with: /\A([^\W][a-zA-Z]\w+)\Z/i, :allow_nil => true
  
  validates_length_of :first_name, minimum: 3, maximum: 30, :allow_nil => true, on: :update
  validates_format_of :first_name, with: /\A([^\d\W]+)\Z/, :allow_nil => true, on: :update

  validates_format_of :last_name, with: /\A([^\d\W]+)\Z/, :allow_nil => true, on: :update
  validates_length_of :last_name, minimum: 3, maximum: 30, :allow_nil => true, on: :update
end
