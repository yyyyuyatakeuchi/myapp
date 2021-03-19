require 'rails_helper'

RSpec.describe "Talent_profile", type: :system do

  before do
    @talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "芸人ユーザーはプロフィール情報編集できる" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    click_link "プロフィール編集"
    
    aggregate_failures do
      expect(page).to have_content("name")
      expect(page).to have_content("芸歴")
      expect(page).to have_content("所属")
      expect(page).to have_content("芸風")
      expect(page).to have_content("自由記入欄")
    end

    fill_in "name", with: "芸人A"
    fill_in "芸歴", with: "30"
    fill_in "所属", with: "yoshimoto"
    fill_in "芸風", with: "ピン芸人"
    fill_in "自由記入欄", with: "よろしくお願い"
    click_button "Update my Profile"

    aggregate_failures do
      expect(page).to have_content("プロフィールを変更しました")
      expect(page).to have_link("芸人A")
      expect(page).to have_content("30")
      expect(page).to have_content("yoshimoto")
      expect(page).to have_content("ピン芸人")
      expect(page).to have_content("よろしくお願い")
    end
  end

  scenario "プロフィール情報でもName属性のバリデーションが有効" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    click_link "プロフィール編集"

    fill_in "name", with: ""
    click_button "Update my Profile"
    expect(page).to have_content("Nameを入力してください")

    fill_in "name", with: "#{"a"*51}"
    click_button "Update my Profile"
    expect(page).to have_content("Nameは50文字以内で入力してください")

    fill_in "name", with: "#{"a"*50}"
    click_button "Update my Profile"
    expect(page).to have_content("プロフィールを変更しました")
  end

  scenario "プロフィール情報でName以外は空白にできる" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    click_link "プロフィール編集"

    fill_in "name", with: "芸人A"
    fill_in "芸歴", with: ""
    fill_in "所属", with: ""
    fill_in "芸風", with: ""
    fill_in "自由記入欄", with: ""
    click_button "Update my Profile"
    expect(page).to have_content("プロフィールを変更しました")
  end
end

#docker-compose run web rspec spec/system/talent_profile_spec.rb