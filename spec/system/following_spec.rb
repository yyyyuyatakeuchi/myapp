require 'rails_helper'

RSpec.describe "Following", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "一般ユーザーマイページ" do
    sign_in @user
    visit root_path
    expect(page).to have_button "フォローする"
    expect(page).to have_link("#{@talent_user.name}")
    expect(page).to_not have_link("#{@user.name}")
    expect(page).to have_link("芸人一覧へ")
    
    click_on "フォローする"
    #visit current_path
    expect(page).to have_button "フォロー解除"
    visit mypage_path(@user)
    expect(page).to have_link("#{@talent_user.name}") 
  end
end

#docker-compose run web rspec spec/system/following_spec.rb