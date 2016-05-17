class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validates :user, :song, presence: true

end