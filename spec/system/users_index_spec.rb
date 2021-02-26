require 'rails_helper'

RSpec.describe "Users index", type: :system do

  before do
    talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    talent_user.create_talent_profile
    talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "芸人一覧表示" do
    visit users_path
    expect(page).to have_link("aaa")

    select '東京', from: 'address'
    click_button "絞り込み"
    expect(page).to have_link("aaa")

    today = Time.zone.today.strftime("%m月%d日")
    select today, from: 'inDate'
    click_button "絞り込み"
    expect(page).to have_link("aaa")
  end
end

#docker-compose run web rspec spec/system/users_index_spec.rb