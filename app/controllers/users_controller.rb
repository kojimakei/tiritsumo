class UsersController < ApplicationController
  before_action :authenticate_user!,only: [:edit, :update,]
  before_action :set_user,only: [:edit, :update,:show]
  
  def show
    @stacks = @user.stacks
    @month  = Date.today.month
    @today = Date.current.strftime('%Y年 %m月 %d日')
    @today_stacks = @stacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @category_total = User.where(category_id: @user.category_id).size
    @age_total = User.where(age_id: @user.age_id).size

    @total_stacks = @stacks.size
    @achieved_stacks = @stacks.where(achieved: 1)
    @stack_rate = ((@achieved_stacks.size.to_f/@total_stacks)*100).round(1)
    @stack_time = @stacks.all.sum(:work_time_id) / 2.0

  end

  def edit
    redirect_to root_path unless current_user.id == @user.id
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)    
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def ranking
    @all_ranks = User.find(Stack.group(:user_id).order('count(user_id) desc').pluck(:user_id))
  end

  private

  def user_params
    params.require(:user).permit(:image, :email, :nickname, :password, :password_confirmation, :goal, :deadline, :age_id, :category_id, :occupation_id)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
