class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user

  def index
    @users = User.all.page(params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_index_path
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
