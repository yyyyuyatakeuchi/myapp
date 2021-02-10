# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
    @talent_signup = params[:talent]
    @followed_user = params[:followed_user]
    super
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    @followed_user = params[:followed_user]
    if @user.save
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      @user.create_talent_profile if @user.isTalent
      sign_in(:user, @user)
      flash[:info] = 'ユーザー登録できました'
      redirect_back_or @user
    else
      @talent_signup = @user.isTalent
      render :new
    end
  end

  def redirect_back_or(user)
    unless @followed_user.blank?
      redirect_to mypage_path(@followed_user)
    else
      redirect_to mypage_path(user)
    end
  end

  # GET /resource/edit
  #def edit
  # super
  #end

  # PUT /resource
  #def update
  #  super
  #end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected
  
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :isTalent, :address, :isPublic])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :isTalent, :address, :isPublic])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
