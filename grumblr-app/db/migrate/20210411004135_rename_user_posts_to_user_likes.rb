class RenameUserPostsToUserLikes < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_posts, :user_likes
  end
end
