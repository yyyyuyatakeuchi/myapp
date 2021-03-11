require 'rails_helper'

RSpec.describe "Home layout", type: :system do
  
  before do
    talent_user = FactoryBot.create(:talent_user, name: "aaa", isPublic: true)
    talent_user.create_talent_profile(history: "44")
  end

  scenario "ホーム画面レイアウト" do
    visit root_path
    aggregate_failures do
      expect(page).to have_content("アプリ概要")
      expect(page).to have_link("芸人一覧へ")
      expect(page).to have_link("ログイン")
      expect(page).to have_link("新規登録")
      expect(page).to have_link("芸人の方はこちら")
      expect(page).to have_link("aaa")
      expect(page).to have_content("44")
    end
  end
end

#docker-compose run web rspec spec/system/home_layout_spec.rb