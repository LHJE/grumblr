require 'rails_helper'

RSpec.describe 'User Like Page' do
  describe 'As a visitor' do
    describe "When I visit the user like page" do
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
      FollowerFollowed.create!(follower_id: @user_1.id, followed_id: @user_3.id)
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
      UserLike.create!(user_id: @user_1.id, post_id: @post_3.id)
      UserLike.create!(user_id: @user_1.id, post_id: @post_4.id)
    end


    it "I can see that I don't have any grumbls in my grumbl feed" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit users_path

      click_link @user_1.name

      expect(page).to have_content("Grumbls That #{@user_1.name} Likes")

      click_link "Grumbls That #{@user_1.name} Likes"

      expect(current_path).to eq("/user/liked/#{@user_1.id}")
      expect(page).to_not have_content(@post_1.content)
      expect(page).to_not have_content(@post_2.content)
      expect(page).to have_content(@post_3.content)
      expect(page).to have_content(@post_3.grass_tags)
      expect(page).to have_content(@post_4.content)
      expect(page).to have_content(@post_4.grass_tags)
    end

  end
end
