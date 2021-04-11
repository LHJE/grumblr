require 'rails_helper'

RSpec.describe 'Profile Page' do
  describe 'As an authenticated  user' do
    before :each do
      @user_1 = User.create(name: 'Jackie Chan', email: '67@67.com', password: '67', password_confirmation: '67')
      @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
      @user_3 = User.create!(name: 'Michelle Yeoh', email: 'c@c.com', password: 'a', password_confirmation: 'a')
      @user_4 = User.create!(name: 'Scott Adkins', email: 'd@d.com', password: 'a', password_confirmation: 'a')
      FollowerFollowed.create!(follower_id: @user_1.id, followed_id: @user_2.id)
      @post_1 = Post.create!(
        content: "This post",
        only_followers: false,
        user_id: @user_1.id
      )
      @post_2 = Post.create!(
        content: "The other post",
        grass_tags: "other",
        only_followers: true,
        user_id: @user_1.id
      )
      @post_3 = Post.create!(
        content: "The hidden post",
        grass_tags: "hidden",
        only_followers: true,
        user_id: @user_2.id
      )
      @post_4 = Post.create!(
        content: "The hidden other post",
        grass_tags: "hidden, other",
        only_followers: true,
        user_id: @user_3.id
      )
    end

    it "If not logged in, I can see my Grumbls if I have Grumbls, but not the only_followers ones" do

      visit "users/#{@user_1.id}"

      expect(page).to have_content("Jackie Chan's Grumbls:")
      expect(page).to have_content(@post_1.content)
      expect(page).to_not have_content(@post_2.content)
      expect(page).to_not have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)
    end

    it "If logged in, I can see my Grumbls if I have Grumbls" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit "users/#{@user_1.id}"

      expect(page).to have_content("Jackie Chan's Grumbls:")
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)
    end
  end
end
