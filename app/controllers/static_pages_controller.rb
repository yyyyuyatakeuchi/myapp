class StaticPagesController < ApplicationController
  def home
    @users = User.where(isTalent: "true")
  end
end
