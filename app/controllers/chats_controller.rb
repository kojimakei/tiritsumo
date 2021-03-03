class ChatsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @chat = current_user.chats.includes(:room).create!(chat_params)
    ActionCable.server.broadcast 'room_channel', chat: @chat.template
  end

  private

  def chat_params
    params.require(:chat).permit(:message).merge(user_id: current_user.id, room_id: @room.id)
  end
end
