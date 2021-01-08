class LikesController < ApplicationController

  def create
    @like = current_user.likes
    @like.create(stack_id: params[:stack_id])
    redirect_to root_path
  end

  def destroy
    @like = Like.find_by(stack_id: params[:stack_id], user_id: current_user.id)
    @like.destroy
    redirect_to root_path
  end
end



