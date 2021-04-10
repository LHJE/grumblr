require 'rails_helper'

RSpec.describe 'Post Index' do
  describe 'As a Visitor' do
    before :each do
      @user = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
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
      UserPost.create!(user_id: @user.id, post_id: @post_1.id)
      UserPost.create!(user_id: @user.id, post_id: @post_2.id)
      UserPost.create!(user_id: @user.id, post_id: @post_3.id)
      visit root_path
    end

    it "visit the website and see public posts" do
      require "pry"; binding.pry
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
    end

  end
end
