require 'rails_helper'

RSpec.describe "Home layout", type: :system do
  
  before do
    @talent_user = FactoryBot.create(:talent_user, name: "aaa", isPublic: true)
    @talent_user.create_talent_profile(history: "44")
  end

  scenario "未ログイン時のホーム画面レイアウト" do
    visit root_path
    aggregate_failures do
      expect(page).to have_content("アプリ概要")
      expect(page).to have_link("芸人一覧へ")
      expect(page).to have_link("ログイン")
      expect(page).to have_link("新規登録")
      expect(page).to have_link("芸人の方はこちら")
      expect(page).to have_link("aaa")
      expect(page).to have_button("フォローする")
      expect(page).to have_content("44")
    end
  end

  scenario "ユーザーログイン時のホーム画面レイアウト" do
    user = FactoryBot.create(:user)
    
    sign_in user
    visit root_path
    aggregate_failures do
      expect(page).to have_content("アプリ概要")
      expect(page).to have_link("芸人一覧へ")
      expect(page).to have_link("ログアウト")
      expect(page).to have_link("aaa")
      expect(page).to have_button("フォローする")
      expect(page).to have_content("44")
    end
  end

  scenario "芸人ログイン時のホーム画面レイアウト" do
    sign_in @talent_user
    visit root_path
    aggregate_failures do
      expect(page).to have_content("アプリ概要")
      expect(page).to have_link("芸人一覧へ")
      expect(page).to have_link("ログアウト")
      expect(page).to have_link("aaa")
      expect(page).to_not have_button("フォローする")
      expect(page).to have_content("44")
    end
  end
end

#docker-compose run web rspec spec/system/home_layout_spec.rb