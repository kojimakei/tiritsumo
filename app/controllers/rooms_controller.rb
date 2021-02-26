class RoomsController < ApplicationController
  before_action :set_stacks, only: [:show, :edit, :update, :destroy, :join]
  before_action :owner_user, only: [:edit, :update, :delete, :destroy]

  def index
    @rooms = Room.all
    @user_rooms = UserRoom.all
  end

  def new
    @room = Room.new
  end

  def create
    @user = current_user
    @room = @user.rooms.new(room_params)
    if @room.save
      current_user.user_rooms.create(room_id: @room.id)
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @user_rooms = UserRoom.all
    @chats = @room.chats.includes(:user)
    @chat = current_user.chats.new
  end

  def join
    @room.users << current_user
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end

  def set_stacks
    @room = Room.find(params[:id])
  end

  def owner_user
    @group = Room.find(params[:id])
    redirect_to rooms_path unless @room.owner?(current_user) || current_user.admin?
  end
end