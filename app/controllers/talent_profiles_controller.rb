class TalentProfilesController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update]
  before_action :correct_user, only:[:edit, :update]


  def edit
  end

  def update
    @user.update!(user_name_params)
    flash[:success] = "プロフィールを変更しました"
    redirect_to mypage_path(@user)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user
  end

  def user_name_params
    params.require(:user).permit(:name, talent_profile_attributes:
      [:history, :belongs, :character, :free_write])
  end
end
