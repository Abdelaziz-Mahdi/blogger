class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.includes(:author, :likes, comments: [:user] ).find_by_id(params[:id])
    @post_comments = @post.comments
    @post_like = @post.likes[0]
    @post_author = @post.author
    @post_comment_author = @post_comments.map(&:user).flatten
  end
end
