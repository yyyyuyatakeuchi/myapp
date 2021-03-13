require 'rails_helper'

RSpec.describe "Sign up", type: :system do
  
  scenario "一般ユーザーとして新規登録" do
    visit root_path
    click_link "新規登録"

    expect{
      fill_in "Name", with: "name"
      fill_in "Eメール", with: "test@example.com"
      fill_in "パスワード", with: "test123"
      fill_in "パスワード（確認用）", with: "test123"
      select '東京', from: 'user_address'
      click_button "Sign up"
    }.to change(User, :count).by(1)

    expect(current_path).to eq root_path
  end

  scenario "芸人として新規登録" do
    visit root_path
    click_link "芸人の方はこちら"

    expect{
      fill_in "Name", with: "Talent_user"
      fill_in "Eメール", with: "test@example.com"
      fill_in "パスワード", with: "test123"
      fill_in "パスワード（確認用）", with: "test123"
      select '東京', from: 'user_address'
      check 'user_isPublic'
      click_button "Sign up"
    }.to change(User, :count).by(1)

    expect(current_path).to eq mypage_path(current_user)
    expect(page).to have_link("Talent_user")
  end
end

#docker-compose run web rspec spec/system/sign_ups_spec.rb