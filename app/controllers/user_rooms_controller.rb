class UserRoomsController < ApplicationController
  def destroy
    @user_room = UserRoom.find(params[:id])
    @user_room.destroy
    redirect_to rooms_path
  end
end
