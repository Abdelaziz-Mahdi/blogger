require 'rails_helper'

RSpec.describe Like, type: :model do
  # test methods
  it "update_likes_counter should update post's likes_counter" do
    user = User.create(name: 'User 1')
    post = Post.create(title: 'Post 1', author: user)
    expect(post.likes_counter).to eq(0)
    Like.create(user:, post:)
    Like.create(user:, post:)
    Like.create(user:, post:)
    expect(post.likes_counter).to eq(3)
  end
end
