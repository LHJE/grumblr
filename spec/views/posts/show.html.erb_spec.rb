require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @user = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @post = assign(:post, Post.create!(
      content: "MyText",
      grass_tags: "Grass Tags",
      only_followers: true,
      user_id: @user.id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Grass Tags/)
  end
end
