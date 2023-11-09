class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params.require(:comment).permit(:text))
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to request.referrer
    else
      redirect_to request.referrer
      flash[:warning] = 'Comment cannot be empty!'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = 'Comment deleted'
    else
      flash[:warning] = 'Comment cannot be deleted'
    end
    redirect_to request.referrer
  end
end
