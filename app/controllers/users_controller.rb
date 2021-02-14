class UsersController < ApplicationController

  def index
    @users = User.where(isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
  end

  def search
    @users = User.where(isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
    if params[:inDate] == "未選択"
      unless params[:address] == "未選択"
        @users = @users.where(address: params[:address])
        @address = params[:address]
      end
    else
      if params[:address] == "未選択"
        @users = @users.joins(:schedules).where(schedules: {inDate: params[:inDate],availability: "◯" })
        @selectDay = params[:inDate]
      else
        @users = @users.joins(:schedules).where(schedules: {inDate: params[:inDate],availability: "◯" }).where(address: params[:address])
        @address = params[:address]
        @selectDay = params[:inDate]
      end
    end
    render :index
  end
end
