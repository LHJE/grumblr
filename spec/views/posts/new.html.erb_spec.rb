require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    @user = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    assign(:post, Post.new(
      content: "MyText",
      grass_tags: "MyString",
      only_followers: true,
      user_id: @user.id
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "textarea[name=?]", "post[content]"

      assert_select "input[name=?]", "post[grass_tags]"
    end
  end
end
