class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
    else
      render 'error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.id == @comment.user_id
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, stack_id: params[:stack_id])
  end
end
