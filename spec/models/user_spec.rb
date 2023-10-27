require 'rails_helper'

RSpec.describe User, type: :model do
  # test validations
  it "name should be present" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "postCount should be greater than or equal to 0" do
    user = User.new(posts_counter: -1)
    user.valid?
    expect(user.errors[:posts_counter]).to include("must be greater than or equal to 0")
  end

  # test methods
  it "should return three most recent posts" do
    user = User.create(name: "User 1")
    Post.create(title: "Post 1", author: user)
    Post.create(title: "Post 2", author: user)
    Post.create(title: "Post 3", author: user)
    Post.create(title: "Post 4", author: user)
    Post.create(title: "Post 5", author: user)
    expect(user.three_most_recent_posts).to eq(user.posts.order(created_at: :desc).limit(3))
  end
end
