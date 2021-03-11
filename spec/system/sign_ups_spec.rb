require 'rails_helper'

RSpec.describe "Sign up", type: :system do
  
  scenario "一般ユーザーとして新規登録" do
    visit root_path
    click_link "新規登録"

    expect{
      fill_in "Name", with: "name"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "test123"
      fill_in "Password confirmation", with: "test123"
      select '東京', from: 'user_address'
      click_button "Sign up"
    }.to change(User, :count).by(1)
  end

  scenario "芸人として新規登録" do
    visit root_path
    click_link "芸人の方はこちら"

    expect{
      fill_in "Name", with: "Talent_user"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "test123"
      fill_in "Password confirmation", with: "test123"
      select '東京', from: 'user_address'
      check 'user_isPublic'
      click_button "Sign up"
    }.to change(User, :count).by(1)

    visit root_path
    expect(page).to have_link("Talent_user")
  end
end

#docker-compose run web rspec spec/system/sign_ups_spec.rb