class UsersController < ApplicationController

  def index
    @users = User.where(isTalent: true).order(created_at: "DESC").page(params[:page])
  end

  def search
    @users = User.where(address: params[:address], isTalent: true).order(created_at: "DESC").page(params[:page])
    render :index
  end
end
