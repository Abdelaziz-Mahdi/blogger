class Api::V1::CommentsController < ApiController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def current_user
    authenticate_with_http_token do |token, options|
      User.find(JsonWebToken.decode(token)[:user_id])
    end
  end

  def index
    @comments = Post.find(params[:post_id]).comments
    render json: @comments
  end

  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
