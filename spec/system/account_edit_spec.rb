require 'rails_helper'

RSpec.describe "AccountEdit", type: :system do

  before do
    @user = FactoryBot.create(:user)
    @talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "一般ユーザーのアカウント情報編集ページレイアウト" do
    sign_in @user
    visit mypage_path(@user)
    click_link "アカウント情報編集"
    expect(page).to have_content("Name")
    expect(page).to have_content("Eメール")
    expect(page).to have_content("Address")
    expect(page).to have_content("パスワード")
    expect(page).to have_content("パスワード（確認用）")
    expect(page).to have_content("現在のパスワード")
  end

  scenario "一般ユーザーがアカウント情報を編集できる" do
    sign_in @user
    visit mypage_path(@user)
    click_link "アカウント情報編集"
    fill_in 'Name', with: 'サンプルユーザー'
    fill_in '現在のパスワード', with: 'password'
    click_button "変更"
    expect(current_path).to eq mypage_path(@user) 
    expect(@user.reload.name).to eq "サンプルユーザー" 
  end

  scenario "芸人のアカウント情報編集ページレイアウト" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    click_link "アカウント情報編集"
    expect(page).to have_content("Name")
    expect(page).to have_content("Eメール")
    expect(page).to have_content("Address")
    expect(page).to have_content("パスワード")
    expect(page).to have_content("パスワード（確認用）")
    expect(page).to have_content("現在のパスワード")
    expect(page).to have_content("一般公開する")
    expect(page).to have_content("非公開にする")
  end

  scenario "芸人がアカウント情報を編集できる" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    click_link "アカウント情報編集"
    fill_in 'Name', with: 'サンプル芸人ユーザー'
    fill_in '現在のパスワード', with: 'password'
    click_button "変更"
    expect(current_path).to eq mypage_path(@talent_user) 
    expect(@talent_user.reload.name).to eq "サンプル芸人ユーザー" 
  end
end

#docker-compose run web rspec spec/system/account_edit_spec.rb