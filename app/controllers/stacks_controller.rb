class StacksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @stacks = Stack.includes(:user).order('created_at DESC')
  end

  def new
    @stack = Stack.new
  end

  def show
    @stack = Stack.find(params[:id])
  end

  def create
    @stack = Stack.new(stack_params)
    if @stack.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def stack_params
    params.require(:stack).permit(:text, :date, :work_time_id).merge(user_id: current_user.id)
  end

end

