class SchedulesController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update]

  def new
    if @schedule = Schedule.find_by(inDate: params[:inDate], user_id: current_user.id)
      @inDate = @schedule.inDate
    else
      @schedule = current_user.schedules.build
      @inDate = params[:inDate]
    end
  end

  def create
    @schedule = current_user.schedules.create(schedule_parameter)
    @user = current_user
    @schedules = Schedule.where(user_id: @user.id)
    respond_to do |format|
      format.html {redirect_to mypage_path(current_user)}
      format.js
    end
  end

  #def edit
    #@schedule = Schedule.find(params[:id])
  #end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update!(edit_schedule_parameter)
    @user = current_user
    @schedules = Schedule.where(user_id: @user.id)
    respond_to do |format|
      format.html {redirect_to mypage_path(current_user)}
      format.js
    end
  end

  private

  def schedule_parameter
    params.require(:schedule).permit(:availability, :inDate, :start_time)
  end

  def edit_schedule_parameter
    params.require(:schedule).permit(:availability)
  end
end