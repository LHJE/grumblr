require 'rails_helper'

RSpec.describe 'Login & Logout' do
  describe 'As a user' do
    before :each do
      @user = User.create!(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')

      visit login_path
    end

    it "If I'm a user, I can fill in my information, click the Log In button, and be logged in as an authenticated user" do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button "Log In"

      expect(current_path).to eq(root_path)
    end

    describe "If already logged in" do
      it "I do not see a login form or register link" do
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password

        click_button "Log In"

        visit login_path

        expect(page).to_not have_content('Email')
        expect(page).to_not have_content('Password')
        expect(page).to_not have_link('Register')
        expect(current_path).to eq(root_path)
      end

      it "I can log out" do
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password

        click_button "Log In"
        click_link "Log Out"

        expect(current_path).to eq(root_path)
        expect(page).to have_content('You have been logged out!')
      end
    end

    describe "If I attempt to login with invalid credentials" do
      it "I see a flash message indicating I cannot log in" do

        fill_in 'Email', with: 'incorrect_email'
        fill_in 'Password', with: @user.password

        click_button "Log In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Sorry, we don't recognize those credentials.")
      end
    end


  end
end
