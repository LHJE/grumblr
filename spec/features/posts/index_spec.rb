require 'rails_helper'

RSpec.describe 'Post Index' do
  before :each do
    @user_1 = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
    @user_3 = User.create!(name: 'Michelle Yeoh', email: 'c@c.com', password: 'a', password_confirmation: 'a')
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
      user_id: @user_3.id
    )
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
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      FollowerFollowed.create!(follower_id: @user_2.id, followed_id: @user_1.id)

      visit root_path
    end

    it "visit the website and see public posts, no posts by users I don't follow, & posts of users I follow" do

      expect(current_path).to eq(root_path)
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to have_content(@post_3.content)
      expect(page).to have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)
    end
  end
end
