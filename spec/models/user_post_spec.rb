require 'rails_helper'

RSpec.describe UserPost, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :post_id}
  end
end
