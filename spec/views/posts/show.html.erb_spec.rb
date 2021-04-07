require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      content: "MyText",
      grass_tags: "Grass Tags",
      only_followers: "Only Followers"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Grass Tags/)
  end
end
