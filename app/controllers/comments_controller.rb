class CommentsController < ApplicationController

  def new
    @comments = Comment.all
    @comment = Comment.new 
  end

  def create
    @comment = Comment.new(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, blog_id: params[:blog_id])
  end
end
