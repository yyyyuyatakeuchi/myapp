class MypageController < ApplicationController
  #before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    if @user.isTalent
      @user_name = @user.talent_profile.name
    else
      @user_name = @user.name
    end
  end
  
end
