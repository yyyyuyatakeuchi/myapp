class UsersController < ApplicationController

  def index
    @users = User.where(isTalent: true).order(created_at: "DESC").page(params[:page])
  end
end
