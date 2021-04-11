require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  describe 'As a Visitor' do
    describe 'I am sent to user show page ' do
      before :each do
        @user = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
        @post = Post.create(
          content: "MyText",
          grass_tags: "Grass Tags",
          only_followers: true,
          user_id: @user.id
        )
      end

      it "visits user page" do
        visit user_path(@user)

        expect(page).to have_content('Name')
        expect(page).to have_content('Jackie Chan')
        expect(page).to have_content('Email')
        expect(page).to have_content('a@a.com')
        expect(page).to_not have_link('Edit')
        expect(page).to_not have_link('Destroy')
        expect(page).to have_link('Back')
      end

      it 'clicks on name on main page' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit user_path(@user)

        expect(page).to have_content('Name')
        expect(page).to have_content('Jackie Chan')
        expect(page).to have_content('Email')
        expect(page).to have_content('a@a.com')
        expect(page).to have_link('Edit')
        expect(page).to have_link('Destroy')
        expect(page).to have_link('Back')
      end
    end
  end
end
