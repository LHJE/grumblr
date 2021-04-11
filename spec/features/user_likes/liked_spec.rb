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

  describe 'As a User' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it "I can like a grumbl from the index" do
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)

      within(".post-#{@post_1.id}") do
        click_link("Like")
      end

      expect(page).to have_content("You have liked the grumbl!")

      within(".post-#{@post_1.id}") do
        expect(page).to have_content("1 Likes")
      end
    end

    it "I can unlike a grumbl from the index" do
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content(@post_2.content)
      expect(page).to have_content(@post_2.grass_tags)
      expect(page).to_not have_content(@post_3.content)
      expect(page).to_not have_content(@post_3.grass_tags)
      expect(page).to_not have_content(@post_4.content)
      expect(page).to_not have_content(@post_4.grass_tags)

      within(".post-#{@post_2.id}") do
        click_link("Unlike")
      end

      expect(page).to have_content("You have unliked the grumbl!")

      within(".post-#{@post_2.id}") do
        expect(page).to have_content("0 Likes")
      end
    end
  end
end
