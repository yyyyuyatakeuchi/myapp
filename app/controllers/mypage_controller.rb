class MypageController < ApplicationController
  #before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
  end
  
end
