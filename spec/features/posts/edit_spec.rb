require 'rails_helper'

RSpec.describe 'Post Edit' do
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
    it "attempt to edit post" do
      visit edit_post_path(@post_1)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You need to be logged in to edit a grumbl.')
    end
  end

  describe 'As a User' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit root_path
    end

    it "attempt to a edit post that isn't mine" do
      visit edit_post_path(@post_2)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You need to be the original grumblr to edit a grumbl.')
    end

    it "I can click the New Post button and be sent to new_post_path"  do
      click_link "Edit"

      expect(current_path).to eq(edit_post_path(@post_1))
    end

    it "I can edit post"  do
      click_link "Edit"

      fill_in 'post[content]', with: 'It is a #new post!'
      fill_in 'post[grass_tags]', with: 'new'
      click_button "Update Post"

      expect(current_path).to eq("/posts/#{@post_1.id}")
      expect(page).to have_content('It is a #new post!')
      expect(page).to have_content("new")
    end

    it "I can edit a post and make it an only_followers post"  do
      click_link "Edit"

      fill_in 'post[content]', with: 'It is a #new post!'
      fill_in 'post[grass_tags]', with: 'new'
      check("Only followers", allow_label_click: true)

      click_button "Update Post"

      expect(current_path).to eq("/posts/#{@post_1.id}")
      expect(page).to have_content('It is a #new post!')
      expect(page).to have_content("new")
    end

    it "I cannot edit a post without content"  do
      click_link "Edit"

      fill_in 'post[content]', with: ''
      fill_in 'post[grass_tags]', with: 'new'

      click_button "Update Post"

      expect(current_path).to eq("/posts/#{@post_1.id}")
      expect(page).to have_content('1 error prohibited this post from being saved:')
      expect(page).to have_content("Content can't be blank")
    end
  end
end
