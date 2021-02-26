require 'rails_helper'

RSpec.describe "Home layout", type: :system do
  before do
    talent_user = FactoryBot.create(:user, name: "aaa", isTalent: true, isPublic: true)
    talent_user.create_talent_profile
  end

  scenario "ホーム画面レイアウト" do
    visit root_path
    expect(page).to have_link("aaa")
    expect(page).to have_link("ログイン")
    expect(page).to have_link("芸人新規登録")
    expect(page).to have_link("ユーザー新規登録")
    expect(page).to have_link("Home")
    expect(page).to have_link("芸人一覧へ")
  end
end

#docker-compose run web rspec spec/system/home_layout_spec.rb