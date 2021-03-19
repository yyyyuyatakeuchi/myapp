require 'rails_helper'

RSpec.describe "Following", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @talent_user = FactoryBot.create(:talent_user)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "芸人をフォローできる" do
    expect{
      sign_in @user
      visit root_path
      expect(page).to have_button "フォローする"
      expect(page).to have_link("#{@talent_user.name}")
      click_on "フォローする"
      expect(page).to have_button "フォロー解除"
      visit mypage_path(@user)
      expect(page).to have_link("#{@talent_user.name}") 
    }.to change(@user.following, :count).by(1)
  end

  scenario "芸人をフォロー解除できる" do
    @user.follow(@talent_user)
    expect{
      sign_in @user
      visit root_path
      expect(page).to have_button "フォロー解除"
      expect(page).to have_link("#{@talent_user.name}")
      click_on "フォロー解除"
      expect(page).to have_button "フォローする"
      visit mypage_path(@user)
      expect(page).to_not have_link("#{@talent_user.name}") 
    }.to change(@user.following, :count).by(-1)
  end
end

#docker-compose run web rspec spec/system/following_spec.rb