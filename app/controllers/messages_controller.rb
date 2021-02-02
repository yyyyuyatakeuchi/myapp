class MessagesController < ApplicationController
  #before_action :set_room, only: [:create]

  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    if message.save
      redirect_to room_path(message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def set_room
    @room = Room.find(params[:message][:room_id])
  end

  def gets_entries_all_messages
    @messages = @room.messages.includes(:user).order("created_at asc")
    @entries = @room.entries
  end

  def message_params
    params.require(:message).permit(:body, :room_id)#.merge(user_id: current_user.id)
  end
end
