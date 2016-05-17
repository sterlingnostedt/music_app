class AddVotes < ActiveRecord::Migration
  
  def change
    create_table :votes, force: :cascade do |t|
    t.integer "user_id"
    t.integer "song_id"
    t.boolean "upvote"
  end
  end
end
