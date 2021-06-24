class CreateFollowerFollowed < ActiveRecord::Migration[6.1]
  def change
    create_table :follower_followeds do |t|
      t.string :follower_id, foreign_key: true
      t.string :followed_id, foreign_key: true

      t.timestamps
    end
  end
end
