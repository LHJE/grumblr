require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    @user = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    assign(:posts, [
      Post.create!(
        content: "MyText",
        grass_tags: "Grass Tags",
        only_followers: true,
        user_id: @user.id
      ),
      Post.create!(
        content: "MyText",
        grass_tags: "Grass Tags",
        only_followers: true,
        user_id: @user.id
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Grass Tags".to_s, count: 2
  end
end
