class FollowerFollowed < ApplicationRecord
  validates :follower_id,
            :followed_id, presence: true
end
