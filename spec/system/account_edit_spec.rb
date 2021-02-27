require 'rails_helper'

RSpec.describe "Mypage", type: :system do

  before do
    @user = FactoryBot.create(:user)
    @talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "一般ユーザーマイページ、アカウント情報編集" do
    sign_in @user
    visit mypage_path(@user)
    click_link "アカウント情報編集"
    #expect(page).to have_content("#{@user.name}")
    expect(page).to have_content("Name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Address")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
    expect(page).to have_content("Current password")
  end

  scenario "一般ユーザーマイページ、アカウント情報編集" do
    sign_in @user
    visit mypage_path(@user)
    click_link "アカウント情報編集"
    fill_in 'Name', with: 'サンプルユーザー'
    fill_in 'Current password', with: 'password'
    click_button "変更"
    expect(current_path).to eq mypage_path(@user) 
    expect(@user.reload.name).to eq "サンプルユーザー" 
  end

  scenario "芸人マイページ、アカウント情報編集" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    click_link "アカウント情報編集"
    expect(page).to have_content("Name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Address")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
    expect(page).to have_content("Current password")
    expect(page).to have_content("一般公開する")
    expect(page).to have_content("非公開にする")
  end
end

#docker-compose run web rspec spec/system/account_edit_spec.rb