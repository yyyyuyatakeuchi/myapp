class MypageController < ApplicationController
  #before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    if @user.isTalent
      @user_name = @user.talent_profile.name
      if user_signed_in?
        @currentUserEntry = Entry.where(user_id: current_user.id)
        @userEntry = Entry.where(user_id: @user.id)
        unless @user.id == current_user.id
          @currentUserEntry.each do |cu|
            @userEntry.each do |u|
              if cu.room_id == u.room_id
                @haveRoom = true
                @roomId = cu.room_id
              end
            end
          end
          unless @haveRoom
            @room = Room.new
            @entry = Entry.new
          end
        end
      end
    else
      @user_name = @user.name
      @users = @user.following.page(params[:page])
    end
  end
  
end
