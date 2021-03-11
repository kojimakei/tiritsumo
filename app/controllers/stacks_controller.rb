class StacksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_stacks, only: [:show, :edit, :update, :destroy]

  def index
    @stacks = Stack.includes(:user).order('created_at DESC')
    @all_ranks = User.find(Stack.group(:user_id).order('count(user_id) desc').limit(3).pluck(:user_id))
  end

  def new
    @stack_tag = StacksTag.new
  end

  def show
    @comment = Comment.new
    @comments = @stack.comments.includes(:user)
    @like = Like.new
  end

  def edit
    redirect_to user_path(@stack.user_id) unless current_user.id == @stack.user_id
    @stack_tag = StacksTag.new(stack: @stack)
  end

  def create
    @stack_tag = StacksTag.new(stack_params)
    tag_list = params[:stack][:name].split(',')
    if @stack_tag.valid? 
      @stack_tag.save(tag_list)
      redirect_to user_path(current_user.id)
      flash[:success] = '投稿しました！'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def update
    @stack_tag = StacksTag.new(stack_params, stack: @stack)
    tag_list = params[:stack][:name].split(",")
    if @stack_tag.valid?
      @stack_tag.save(tag_list)
      redirect_to user_path(current_user.id)
      flash[:success] = '更新しました！'
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @stack.destroy if current_user.id == @stack.user_id
    redirect_to root_path
  end

  def achieved
    stack = Stack.find(params[:id])
    if stack.achieved
      stack.update(achieved: false)
    else
      stack.update(achieved: true)
    end
    # 更新したレコードをitem変数に変更し直し
    item = Stack.find(params[:id])
    render json: { stack: item }
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def stack_params
    params.require(:stack).permit(:text, :date, :work_time_id, :achieved, :name,:tag_id).merge(user_id: current_user.id)
  end

  def set_stacks
    @stack = Stack.find(params[:id])
  end
end
