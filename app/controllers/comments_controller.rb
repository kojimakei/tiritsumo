class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to stack_path(@comment.stack)
    else
      @stack = @comment.stack
      @comments = @stack.comments
      render "stacks/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render "stacks/show"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, stack_id: params[:stack_id])
  end
end

