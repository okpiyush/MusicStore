class User < ApplicationRecord
  has_secure_password
  validates :name , presence: true
  validates :email, presence: true
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :active_follows, source: :followed

  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower
end
