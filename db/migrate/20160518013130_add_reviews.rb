class AddReviews < ActiveRecord::Migration
  def change
      create_table :reviews do |t|
      t.references :user
      t.references :song
      t.string :title
      t.integer :rating
      t.string :content
    end
  end
end
