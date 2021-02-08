class StaticPagesController < ApplicationController
  def home
    @users = User.where(isTalent: "true", isPublic: "true").order(created_at: "DESC").first(5)
  end
end
