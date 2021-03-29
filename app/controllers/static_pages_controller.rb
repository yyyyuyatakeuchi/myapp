class StaticPagesController < ApplicationController
  def home
    @users = User.where(isTalent: true, isPublic: true).order(created_at: "DESC").first(5)
  end

  def new_guest
    email = "#{SecureRandom.base64(10)}@guest.com"
    user = User.find_or_create_by!(name: 'GuestUser', email: email, isTalent: params[:talent]) do |user|
      user.password = "password"
      user.confirmed_at = Time.now
      user.created_at = Time.current.prev_year
    end
    user.create_talent_profile if user.isTalent
    sign_in user
    redirect_to mypage_path(user), notice: 'ゲストユーザーとしてログインしました。'
  end
end
