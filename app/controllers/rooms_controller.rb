class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
    @room.users << current_user
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats.includes(:user).order(:id).last(100)
    @chat = current_user.chats.new
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
end
