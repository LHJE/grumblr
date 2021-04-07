require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        content: "MyText",
        grass_tags: "Grass Tags",
        only_followers: "Only Followers"
      ),
      Post.create!(
        content: "MyText",
        grass_tags: "Grass Tags",
        only_followers: "Only Followers"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Grass Tags".to_s, count: 2
  end
end
