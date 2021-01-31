class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.isTalent
      mypage_path(resource)
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    if resource.isTalent
      mypage_path(resource)
    else
      root_path
    end
  end

  
end
