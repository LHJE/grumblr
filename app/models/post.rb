class Post < ApplicationRecord
  validates :content,
            :user_id, presence: true
  validates :grass_tags,
            :only_followers, presence: false

  belongs_to :user
end
