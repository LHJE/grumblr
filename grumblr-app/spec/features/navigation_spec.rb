require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    describe 'I see a nav bar where I can link to' do
      it 'the welcome page' do
        visit login_path

        within 'nav' do
          click_link 'Home'
        end

        expect(current_path).to eq(root_path)
      end

      it 'the login page' do
        visit root_path

        within 'nav' do
          click_link 'Log In'
        end

        expect(current_path).to eq(login_path)
      end

      it 'the registraton page' do
        visit root_path

        within 'nav' do
          click_link 'Register'
        end

        expect(current_path).to eq(registration_path)
      end

      it 'the logout link' do
        visit root_path

        expect(page).to_not have_link('Log Out')
      end

      it 'the Profile link' do
        visit root_path

        expect(page).to_not have_link('Profile')
      end

      it 'the Dashboard link' do
        visit root_path

        expect(page).to_not have_link('Dashboard')
      end
    end
  end

  describe 'As a User' do
    before :each do
      @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'a', password_confirmation: 'a')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe 'I see a nav bar where I can link to' do
      it 'the welcome page' do
        visit user_dashboard_path

        within 'nav' do
          click_link 'Home'
        end

        expect(current_path).to eq(root_path)
      end

      it 'the profile page' do
        visit user_dashboard_path

        within 'nav' do
          click_link 'Profile'
        end

        expect(current_path).to eq('/users/11')
      end

      it 'the dashboard page' do
        visit root_path

        within 'nav' do
          click_link 'Dashboard'
        end

        expect(current_path).to eq(user_dashboard_path)
      end

      it 'the logout page' do
        visit root_path

        within 'nav' do
          click_link 'Log Out'
        end

        expect(current_path).to eq(root_path)
        expect(page).to have_content('You have been logged out!')
      end
    end

    describe 'I do not see in my nav bar' do
      it 'the login link' do
        visit root_path

        expect(page).to_not have_link('Log In')
      end

      it 'the registration link' do
        visit root_path

        expect(page).to_not have_link('Register')
      end
    end
  end
end
