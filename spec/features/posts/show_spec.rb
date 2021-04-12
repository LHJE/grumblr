require 'rails_helper'

RSpec.describe 'Post Show' do
  before :each do
    @user_1 = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @post_1 = Post.create!(
      content: "This post",
      only_followers: false,
      user_id: @user_1.id
    )
  end

  describe 'As a Visitor' do
    it "visit the post and see its info" do
      visit "posts/#{@post_1.id}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content("Content:")
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content("Grass Tags:")
      expect(page).to have_content("Likes")
      expect(page).to have_content("0")
      expect(page).to have_content("Like")
      expect(page).to have_content("Back")
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Destroy")
    end
  end

  describe 'As a User' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "posts/#{@post_1.id}"
    end

    it "visit the post and see its info, and be able to edit it"  do

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content("Content:")
      expect(page).to have_content(@post_1.content)
      expect(page).to have_content("Grass Tags:")
      expect(page).to have_content("Likes")
      expect(page).to_not have_content("Like ")
      expect(page).to_not have_content("Unlike")
      expect(page).to have_content("Back")
      expect(page).to have_content("Edit")
      expect(page).to have_content("Destroy")
    end
  end
end
