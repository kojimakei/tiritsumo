class RoomsController < ApplicationController
  before_action :set_stacks, only: [:show, :edit, :update, :destroy, :join]

  def index
    @rooms = Room.all
    @user_rooms = UserRoom.all
  end

  def new
    @room = Room.new
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
    @user_rooms = UserRoom.all
    @chats = @room.chats.includes(:user)
    @chat = current_user.chats.new
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "グループを削除しました。"
  end




  def join
    @room.users << current_user
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name).merge(user_id: current_user.id)
  end

  def set_stacks
    @room = Room.find(params[:id])
  end

end