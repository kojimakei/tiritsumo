class UsersController < ApplicationController
  before_action :authenticate_user!,only: [:edit, :update,]
  before_action :set_user,only: [:edit, :update,:show]
  
  def show
    @stacks = @user.stacks
    @today = Date.current.strftime('%Y年 %m月 %d日')
    @today_stacks = @stacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
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

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :password, :password_confirmation, :goal, :deadline, :age_id, :category_id, :occupation_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
