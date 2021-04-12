require 'rails_helper'

RSpec.describe 'Post Destory' do
  before :each do
    @user_1 = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
    @post_1 = Post.create!(
      content: "This post",
      only_followers: false,
      user_id: @user_1.id
    )
    @post_2 = Post.create!(
      content: "The other post",
      grass_tags: "other",
      only_followers: false,
      user_id: @user_2.id
    )
  end

  describe 'As a Visitor' do
    it "visit the post and see its info" do
      visit "posts/#{@post_1.id}/destroy"

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You need to be logged in to destroy a grumbl.')
    end
  end

  describe 'As a User' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it "visit the post and see its info" do
      visit "posts/#{@post_2.id}/destroy"

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You need to be the original grumblr to destroy a grumbl.')
    end

    it "I can destroy my post" do
      visit root_path

      click_link "Destroy"

      expect(current_path).to eq('/posts')
      expect(page).to have_content("Grumbl was successfully destroyed.")
      expect(page).to_not have_content(@post_1.content)
    end
  end
end
