class RoomsController < ApplicationController
  before_action :set_stacks, only: [:show, :edit, :update, :destroy, :join]
  before_action :authenticate_user!, except: [:index]

  def index
    @rooms = Room.all.order('created_at DESC')
    @user_rooms = UserRoom.all
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      current_user.user_rooms.create(room_id: @room.id)
    else
      redirect_to rooms_path
    end
  end

  def show
    @user_rooms = UserRoom.all
    @user_room = UserRoom.find_by(user_id: current_user.id, room_id: params[:id])
    @chats = @room.chats.includes(:user)
    @chat = current_user.chats.new
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to rooms_path
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
  end

  def join
    @room.users << current_user
    redirect_to room_path(@room)
  end

  def search
    @rooms = Room.search(params[:keyword])
    @user_rooms = UserRoom.all
  end

  private

  def room_params
    params.require(:room).permit(:name, :image).merge(user_id: current_user.id)
  end

  def set_stacks
    @room = Room.find(params[:id])
  end
end
