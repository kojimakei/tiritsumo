class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.create(comment_params)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, stack_id: params[:stack_id])
  end
end
