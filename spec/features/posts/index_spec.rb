require 'rails_helper'

RSpec.describe 'Post Index' do
  before :each do
    @user_1 = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
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
    UserPost.create!(user_id: @user_1.id, post_id: @post_1.id)
    UserPost.create!(user_id: @user_1.id, post_id: @post_2.id)
    UserPost.create!(user_id: @user_1.id, post_id: @post_3.id)
  end

  describe 'As a Visitor' do
    it "visit the website and see public posts" do
      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
    end
  end

  describe 'As a User' do
    it "visit the website and see public posts, & not posts of users I don't follow" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit root_path
      
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
    end
  end
end
