require 'rails_helper'

RSpec.describe Post, type: :model do
  # test validations
  it "title should be present" do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "title should not be longer than 250 characters" do
    post = Post.new(title: "a" * 251)
    post.valid?
    expect(post.errors[:title]).to include("is too long (maximum is 250 characters)")
  end

  it "commentsCount should be greater than or equal to 0" do
    post = Post.new(comments_counter: -1)
    post.valid?
    expect(post.errors[:comments_counter]).to include("must be greater than or equal to 0")
  end

  it "likesCount should be greater than or equal to 0" do
    post = Post.new(likes_counter: -1)
    post.valid?
    expect(post.errors[:likes_counter]).to include("must be greater than or equal to 0")
  end

  # test methods
  it "last_five_comments should return five most recent comments" do
    post = Post.create(title: "Post 1")
    Comment.create(text: "Comment 1", post: post)
    Comment.create(text: "Comment 2", post: post)
    Comment.create(text: "Comment 3", post: post)
    Comment.create(text: "Comment 4", post: post)
    Comment.create(text: "Comment 5", post: post)
    Comment.create(text: "Comment 6", post: post)
    expect(post.last_five_comments).to eq(post.comments.last(5))
  end

  it "update_posts_counter should update author's posts_counter" do
    user = User.create(name: "User 1")
    Post.create(title: "Post 1", author: user)
    Post.create(title: "Post 2", author: user)
    Post.create(title: "Post 3", author: user)
    Post.create(title: "Post 4", author: user)
    Post.create(title: "Post 5", author: user)
    expect(user.posts_counter).to eq(5)
  end
end
