require 'rails_helper'

RSpec.describe 'UserLiked' do
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
      only_followers: false,
      user_id: @user_2.id
    )
    @post_4 = Post.create!(
      content: "The hidden other post",
      grass_tags: "hidden, other",
      only_followers: true,
      user_id: @user_3.id
    )
    UserLike.create!(user_id: @user_1.id, post_id: @post_2.id)
  end

  describe 'As a Visitor' do
    it "I cannot like a grumbl on the root" do
      visit root_path

      within(".post-#{@post_1.id}") do
        click_link("Like")
      end

      expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
      expect(current_path).to eq(login_path)
    end

    it "I cannot like a grumbl on the show page" do
      visit "posts/#{@post_1.id}"

      click_link("Like")

      expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
      expect(current_path).to eq(login_path)
    end
  end

  
end
