class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @like = current_user.likes.new(stack_id: params[:stack_id])
    if @like.save
    redirect_to stack_path(@like.stack)
    else
      render 'stacks/show'
    end
  end

  def destroy
    @like = Like.find_by(stack_id: params[:stack_id], user_id: current_user.id)
    @like.destroy
    redirect_to stack_path(@like.stack)
  end
end



