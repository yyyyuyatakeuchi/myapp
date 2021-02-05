class StaticPagesController < ApplicationController
  def home
    @users = User.where(isTalent: "true").order(created_at: "DESC").first(5)
  end
end
