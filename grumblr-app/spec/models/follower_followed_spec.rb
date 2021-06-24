require 'rails_helper'

RSpec.describe FollowerFollowed, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :follower_id}
    it {should validate_presence_of :followed_id}
  end
end
