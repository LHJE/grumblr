require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      content: "MyText",
      grass_tags: "MyString"
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
