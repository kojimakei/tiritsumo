class StacksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_stacks, only: [:show, :edit, :update, :destroy]

  def index
    @stacks = Stack.includes(:user).order('created_at DESC')
  end

  def new
    @stack = Stack.new
  end

  def show
    @comment = Comment.new
    @comments = @stack.comments.includes(:user)
  end

  def edit
    redirect_to root_path unless current_user.id == @stack.user_id
  end

  def create
    @stack = Stack.new(stack_params)
    if @stack.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @stack = Stack.find(params[:id])
    if @stack.update(stack_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @stack.destroy if current_user.id == @stack.user_id
    redirect_to root_path
  end

  private

  def stack_params
    params.require(:stack).permit(:text, :date, :work_time_id).merge(user_id: current_user.id)
  end

  def set_stacks
    @stack = Stack.find(params[:id])
  end
end
