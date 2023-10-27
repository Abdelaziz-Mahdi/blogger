require 'rails_helper'

RSpec.describe Comment, type: :model do
  # test methods
  it 'should update comments_counter after create' do
    user = User.create(name: 'User 1')
    post = Post.create(title: 'Post 1', author: user)
    expect(post.comments_counter).to eq(0)
    Comment.create(user:, post:)
    expect(post.comments_counter).to eq(1)
  end
end
