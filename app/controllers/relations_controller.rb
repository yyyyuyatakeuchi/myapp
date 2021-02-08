class RelationsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    redirect_to root_url unless @user.isPublic
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    @user = Relation.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "ログインしてください"
      redirect_to new_user_registration_path
    end
  end
end