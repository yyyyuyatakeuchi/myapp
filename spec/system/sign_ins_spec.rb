require 'rails_helper'

RSpec.describe "Sign in", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:talent_user) { FactoryBot.create(:user, isTalent: true, isPublic: true) }

  scenario "一般ユーザーとしてログイン" do
    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Log in"

    expect(page).to have_content "ログインしました。"
    expect(page).to have_link "ログアウト"
    expect(page).to_not have_link "ログイン"
  end

  scenario "芸人としてログイン" do
    talent_user.create_talent_profile

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: talent_user.email
    fill_in "パスワード", with: talent_user.password
    click_button "Log in"

    expect(current_path).to eq mypage_path(talent_user)
    expect(page).to have_content "#{talent_user.name}"
    expect(page).to have_link "プロフィール編集"
    expect(page).to have_link "アカウント情報編集"
  end
end

#docker-compose run web rspec spec/system/sign_ins_spec.rb