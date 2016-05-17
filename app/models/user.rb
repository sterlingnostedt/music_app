class User < ActiveRecord::Base

  has_many :tracks
  has_many :votes

  validates :username, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }
end