require 'rails_helper'

RSpec.describe 'User Destruction' do
  describe 'As an authenticated user' do
    describe "When I click to delete my account" do
      before :each do
        @user_1 = User.create(name: 'Jackie Chan', email: '67@67.com', password: '67', password_confirmation: '67')
        @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
        FollowerFollowed.create!(follower_id: @user_2.id, followed_id: @user_1.id)
        FollowerFollowed.create!(follower_id: @user_1.id, followed_id: @user_2.id)
        @post_1 = Post.create!(
          content: "This post",
          only_followers: false,
          user_id: @user_1.id
        )
        @post_2 = Post.create!(
          content: "The other post",
          grass_tags: "other",
          only_followers: false,
          user_id: @user_1.id
        )
        @post_3 = Post.create!(
          content: "The hidden post",
          grass_tags: "hidden",
          only_followers: true,
          user_id: @user_1.id
        )
        @post_4 = Post.create!(
          content: "The hidden other post",
          grass_tags: "hidden, other",
          only_followers: true,
          user_id: @user_2.id
        )
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit user_dashboard_path
      end

      it "I can delete my account" do

        expect(page).to have_button('Delete')

        click_button 'Delete'

        expect(current_path).to eq(users_path)
      end
    end
  end
end
