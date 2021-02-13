class UsersController < ApplicationController

  def index
    @users = User.where(isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
  end

  def search
    if params[:inDate] == "未選択"
      if params[:address] == "未選択"
        @users = User.where(isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
      else
        @users = User.where(address: params[:address], isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
        @address = params[:address]
      end
      render :index
    else
      if params[:address] == "未選択"
        @users = User.where(isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
        @users = @users.joins(:schedules).where(schedules: {inDate: params[:inDate],availability: "◯" })
        @selectDay = params[:inDate]
      else
        @users = User.where(address: params[:address], isTalent: true, isPublic: true).order(created_at: "DESC").page(params[:page])
        @users = @users.joins(:schedules).where(schedules: {inDate: params[:inDate],availability: "◯" })
        @address = params[:address]
        @selectDay = params[:inDate]
      end
      render :index
    end
  end
end
