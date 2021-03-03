class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_stack, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(stack_id: params[:stack_id])
    @like.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @like = Like.find_by(stack_id: params[:stack_id], user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  def set_stack
    @stack = Stack.find(params[:stack_id])
  end
end
