require 'rails_helper'

RSpec.describe 'User Index Page' do
  describe 'As an authenticated  user' do
    before :each do
      @user_1 = User.create(name: 'Jackie Chan', email: '67@67.com', password: '67', password_confirmation: '67')
      @user_2 = User.create!(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'a', password_confirmation: 'a')
      @user_3 = User.create!(name: 'Michelle Yeoh', email: 'c@c.com', password: 'a', password_confirmation: 'a')
      @user_4 = User.create!(name: 'Scott Adkins', email: 'd@d.com', password: 'a', password_confirmation: 'a')
    end

    it "If not logged in, I can see another user's if they have Grumbls, but not the only_followers ones" do
      visit "/users"

      expect(page).to have_content("Grumblrs")
      expect(page).to have_content("Name")
      expect(page).to have_content("Email")
      expect(page).to have_content('Jackie Chan')
      expect(page).to have_content('67@67.com')
      expect(page).to have_content('Cynthia Rothrock')
      expect(page).to have_content('b@b.com')
      expect(page).to have_content('Michelle Yeoh')
      expect(page).to have_content( 'c@c.com',)
      expect(page).to have_content('Scott Adkins')
      expect(page).to have_content('d@d.com')
      expect(page).to have_content('Show')
      expect(page).to_not have_content('Edit')
      expect(page).to_not have_content('Destroy')
    end

    it "If logged in, I can see my Grumbls if I have Grumbls" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit "/users"
      expect(page).to have_content('Edit')
      expect(page).to have_content('Destroy')

    end

  end
end
