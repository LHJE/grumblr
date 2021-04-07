class FollowerFollowed < ApplicationRecord
  validates :follower_id,
            :followed_id, presence: true

  belongs_to :user
end
