require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :content}
    it {should allow_value(false).for(:grass_tags)}
    it {should allow_value(false).for(:only_followers)}
  end
end
