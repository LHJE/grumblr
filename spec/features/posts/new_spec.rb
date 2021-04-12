require 'rails_helper'

RSpec.describe 'Post New' do
  before :each do
    @user_1 = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
  end

  describe 'As a Visitor' do
    it "attempt to make a new post" do
      visit root_path

      click_button "New Post"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You need to be logged in to grumbl.")
    end
  end

  describe 'As a User' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit root_path
    end

    it "I can click the New Post button and be sent to new_post_path"  do
      click_button "New Post"

      expect(current_path).to eq(new_post_path)
    end

    it "I can make a new post"  do
      click_button "New Post"

      fill_in 'post[content]', with: 'It is a #new post!'
      fill_in 'post[grass_tags]', with: 'new'

      click_button "Create Post"

      expect(current_path).to eq("/posts/#{Post.all[-1].id}")
      expect(page).to have_content('It is a #new post!')
      expect(page).to have_content("new")
    end

    it "I can make an only_followers new post"  do
      click_button "New Post"

      fill_in 'post[content]', with: 'It is a #new post!'
      fill_in 'post[grass_tags]', with: 'new'
      check("Only followers", allow_label_click: true)

      click_button "Create Post"

      expect(current_path).to eq("/posts/#{Post.all[-1].id}")
      expect(page).to have_content('It is a #new post!')
      expect(page).to have_content("new")
    end

    it "I cannot make a new post without content"  do
      click_button "New Post"

      fill_in 'post[grass_tags]', with: 'new'

      click_button "Create Post"

      expect(current_path).to eq('/posts')
      expect(page).to have_content('1 error prohibited this post from being saved:')
      expect(page).to have_content("Content can't be blank")
    end
  end
end
