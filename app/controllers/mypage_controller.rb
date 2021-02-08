class MypageController < ApplicationController
  before_action :when_could_show_mypage_only_myself
  
  def show
    if @user.isTalent
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
      following_users = @user.following.page(params[:page])
      @users = following_users.where(public: true)
    end
  end
  
  def when_could_show_mypage_only_myself
    @user = User.find(params[:id])
    if @user.isTalent && !@user.isPublic
      unless @user == current_user
        redirect_to root_url
      end
    end
    unless @user.isTalent
      unless @user == current_user
        redirect_to root url
      end
    end
  end
end
