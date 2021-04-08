require 'rails_helper'

RSpec.describe "users/index", type: :feature do
  before(:each) do
    User.create!(
      name: "Jackie",
      email: "Email",
      password: 'a',
      password_confirmation: 'a'
    )
    User.create!(
      name: "Dane",
      email: "Email2",
      password: 'a',
      password_confirmation: 'a'
    )
  end

  it "renders a list of users" do
    visit users_path
    expect(page).to have_content('Jackie')
    expect(page).to have_content('Dane')
  end
end
