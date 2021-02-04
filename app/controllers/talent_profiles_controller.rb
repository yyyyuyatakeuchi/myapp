class TalentProfilesController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_name_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to mypage_path(@user)
    else
      render :edit
    end
  end

  def user_name_params
    params.require(:user).permit(:name, talent_profile_attributes:
      [:history, :belongs, :character, :free_write])
  end
end
