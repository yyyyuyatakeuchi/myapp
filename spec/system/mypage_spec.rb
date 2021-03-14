require 'rails_helper'

RSpec.describe "Mypage", type: :system do

  before do
    @user = FactoryBot.create(:user)
    @talent_user = FactoryBot.create(:talent_user, name: "aaa", address: "tokyo", isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "一般ユーザーマイページレイアウト" do
    aggregate_failures do
      sign_in @user
      visit mypage_path(@user)
      expect(page).to have_link("アカウント情報編集")
      expect(page).to have_link("DM一覧ページへ")
    end
  end

  scenario "芸人マイページレイアウト" do
    aggregate_failures do
      sign_in @talent_user
      visit mypage_path(@talent_user)
      expect(page).to have_link("アカウント情報編集")
      expect(page).to have_link("DM一覧ページへ")
      expect(page).to have_link("#{@talent_user.name}")
      expect(page).to have_link("一般公開中")
      expect(page).to have_link("プロフィール編集")
      expect(page).to have_content("ピン芸人")
      expect(page).to have_content("よろしく")
    end
  end
end

#docker-compose run web rspec spec/system/mypage_spec.rb