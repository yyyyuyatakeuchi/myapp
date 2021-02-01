class TalentProfilesController < ApplicationController
  before_action :authenticate_user! 

  def edit
    @profile = TalentProfile.find_by(user_id: current_user.id)
  end

  def update
    @profile = TalentProfile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      redirect_to mypage_path(current_user.id)
    else
      render :edit
    end
  end

  def profile_params
    params.require(:talent_profile).permit(
      :name, :history, :belongs, :character, :free_write
    )
  end
end
