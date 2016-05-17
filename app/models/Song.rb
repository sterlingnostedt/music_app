class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true, length: { maximum: 200 }
  validates :author, presence: true, length: { maximum: 60 }

  def upvote_count
    self.votes.size
  end

end