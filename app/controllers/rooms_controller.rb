class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.includes(:messages).order("messages.created_at desc")
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages#.includes(:user).order("created_at asc")
      @message = Message.new
      @entries = @room.entries
    else
      edirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create
    @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
    @joinUser = Entry.create(join_room_params)
    redirect_to room_path(@room)
  end

  private
    def join_room_params
      params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
    end
end
