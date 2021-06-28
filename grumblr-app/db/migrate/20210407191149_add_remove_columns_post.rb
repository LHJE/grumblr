class AddRemoveColumnsPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :only_followers, :string
    add_column :posts, :only_followers, :boolean
  end
end
