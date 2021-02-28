class UserRoomsController < ApplicationController

  def destroy
    @user_room = UserRoom.find_by(user_id: current_user.id)
    @user_room.destroy
    redirect_to rooms_path
  end
end
