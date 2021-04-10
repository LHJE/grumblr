require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @user = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @post = assign(:post, Post.create!(
      content: "MyText",
      grass_tags: "MyString",
      only_followers: true,
      user_id: @user.id
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "textarea[name=?]", "post[content]"

      assert_select "input[name=?]", "post[grass_tags]"
    end
  end
end
