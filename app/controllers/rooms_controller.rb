class RoomsController < ApplicationController

  def index
    if user_signed_in?
      @room = Room.new
      @rooms = Room.all
    end
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      current_user.user_rooms.create(room_id: @room.id)
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats
  end


  private
  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end
