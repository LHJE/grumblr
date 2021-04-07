class Post < ApplicationRecord
  validates :content,
            :only_followers, presence: true
  validates :grass_tags, presence: false
end
