class RoomsController < ApplicationController

  def index
    @rooms = Room.all
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
    @room = Room.find(params[:id])
    @chats = @room.chats.includes(:user)
    @chat = current_user.chats.new
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end
end

