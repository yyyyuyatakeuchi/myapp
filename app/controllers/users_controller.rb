class UsersController < ApplicationController
  def index
    @users = User.where(isTalent: true).page(params[:page])
  end
end
