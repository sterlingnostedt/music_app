class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validates :user, :song, presence: true

  validate :song_exists
  validate :user_has_not_upvoted_this_song_before, if: :upvoting
  validate :user_has_not_downvoted_this_song_before, if: :downvoting
  # before_save :has_user_voted_for_track_before?

  def song_exists
    existing_song = Song.where(id: self.song_id).first
    errors.add(:song_id, 'must exist to be voted on') unless existing_song
  end

  def user_has_not_upvoted_this_song_before
    existing_upvote = Vote.where(user_id: self.user_id, song_id: self.song_id, upvote: true).first
    errors.add(:user_id, 'has upvoted this song before') if existing_upvote
  end

  def user_has_not_downvoted_this_song_before
    existing_downvote = Vote.where(user_id: self.user_id, song_id: self.song_id, upvote: false).first
    errors.add(:user_id, 'has downvoted this song before') if existing_downvote
  end

  def upvoting
    self.upvote == true
  end

  def downvoting
    self.upvote == false 
  end

end