class SchedulesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_schedules, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = Schedule.includes(:user)
    # render 'schedules',formats: :json , handlers: 'jbuilder'
    @schedules = current_user.schedules
    @schedule = Schedule.new
    @user = current_user
  end
    
  def show
    
  end

  def create
    @schedules = current_user.schedules
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
      redirect_to root_path
    else
      render 'users/index'
    end
  end

  def destroy
    @schedule.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:date, :begin_time, :finish_time, :plan)
  end

  def set_schedules
    @schedule = Schedule.find(params[:id])
  end
end
