require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Dashboard Page' do
  describe 'As a visitor' do
    describe "When I visit the dashboard page" do
      it "I can see a message telling me to login to see this page" do
        visit 'user/dashboard'
        expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe 'As an authenticated  user' do
    before :each do
      @user_1 = User.create(name: 'Jackie Chan', email: '67@67.com', password: '67', password_confirmation: '67')
      @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
      @user_3 = User.create!(name: 'Michelle Yeoh', email: 'c@c.com', password: 'a', password_confirmation: 'a')
      @user_4 = User.create!(name: 'Scott Adkins', email: 'd@d.com', password: 'a', password_confirmation: 'a')
      FollowerFollowed.create!(follower_id: @user_1.id, followed_id: @user_2.id)
      @post_1 = Post.create!(
        content: "This post",
        only_followers: false
      )
      @post_2 = Post.create!(
        content: "The other post",
        grass_tags: "other",
        only_followers: false
      )
      @post_3 = Post.create!(
        content: "The hidden post",
        grass_tags: "hidden",
        only_followers: true
      )
      @post_4 = Post.create!(
        content: "The hidden other post",
        grass_tags: "hidden, other",
        only_followers: true
      )
      UserPost.create!(user_id: @user_1.id, post_id: @post_1.id)
      UserPost.create!(user_id: @user_1.id, post_id: @post_2.id)
      UserPost.create!(user_id: @user_2.id, post_id: @post_3.id)
      UserPost.create!(user_id: @user_3.id, post_id: @post_4.id)
    end

    it "I can see that I have Grumbls if I have Grumbls" do
      visit login_path

      fill_in 'Email', with: @user_1.email
      fill_in 'Password', with: @user_1.password

      click_button "Log In"

      visit user_dashboard_path

      expect(page).to have_content("Welcome Jackie Chan!")
      expect(page).to have_content("Grumbls by Grumblrs you follow:")
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to have_content(@post_3.content)
      expect(page).to have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)
    end

    it "I can see that I don't have NPCs if I don't have NPCs" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_4)

      visit user_dashboard_path

      expect(page).to have_content("You've never grumbld, and either you aren't following anyone or they've never grumbld.")
      expect(page).to_not have_content(@post_1.content)
      expect(page).to_not have_content(@post_2.content)
      expect(page).to_not have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)
    end

  end
end
