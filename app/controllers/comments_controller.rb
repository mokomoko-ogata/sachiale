class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    ActionCable.server.broadcast 'comment_channel', content: @comment if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, blog_id: params[:blog_id])
  end
end
