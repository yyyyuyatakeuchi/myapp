require 'rails_helper'

RSpec.describe "DM", type: :system do

  before do
    @user = FactoryBot.create(:user)
    @talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "ダイレクトメッセージ送信後、メッセージルームへのリンクの表示が変わり、DM一覧が更新される" do
    sign_in @user
    visit mypage_path(@talent_user)
    click_on "ダイレクト・チャット", match: :first
    expect(page).to have_link("#{@talent_user.name}") 
    fill_in "message_body", with: "こんにちは"
    click_button "投稿"
    expect(page).to have_content "こんにちは"

    visit mypage_path(@talent_user)
    expect(page).to have_link "チャットルームへ"
    
    visit mypage_path(@user)
    click_link "DM一覧ページへ"
    expect(page).to have_link "#{@talent_user.name}"
    expect(page).to have_link "こんにちは"
    click_link "こんにちは"
    expect(page).to have_content "ダイレクトメッセージ"
    expect(page).to have_link "#{@talent_user.name}"
    expect(page).to have_content "こんにちは"
  end
end

#docker-compose run web rspec spec/system/DM_spec.rb