class TalentProfilesController < ApplicationController
  before_action :authenticate_user! 

  def new
    
  end

  def edit
    
  end

  def create
    
  end

  def update
    @profile = TalentProfile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to mypage_path(current_user.id)
    else
      render :new
    end
  end

  def destroy

  end

  def profile_params
    params.require(:talent_profile).permit(
      :history, :belongs, :character, :free
    )
  end
end
