require 'rails_helper'

RSpec.describe "Users index", type: :system do

  before do
    @talent_user = FactoryBot.create(:talent_user, address: "tokyo", isPublic: true)
    @talent_user.create_talent_profile
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
    visit users_path
  end

  scenario "isPublic属性がtrueの芸人が一覧に表示される" do
    expect(page).to have_link("#{@talent_user.name}")
  end

  scenario "isPublic属性がfalseの芸人は一覧に表示されない" do
    other_talent = FactoryBot.create(:talent_user, name: "非公開芸人", isPublic: false)
    other_talent.create_talent_profile
    visit users_path
    expect(page).to have_link("#{@talent_user.name}")
    expect(page).to_not have_link("非公開芸人")
  end

  scenario "address属性が東京の芸人だけが絞り込み表示される" do
    select '東京', from: 'address'
    click_button "絞り込み"
    expect(page).to have_link("#{@talent_user.name}")
  end

  scenario "address属性が大阪の芸人だけが絞り込み表示される" do
    select '大阪', from: 'address'
    click_button "絞り込み"
    expect(page).to_not have_link("#{@talent_user.name}")
  end

  scenario "日付絞り込み検索でカレンダーが今日”◯”のユーザーのみを表示" do
    today = Time.zone.today.strftime("%m月%d日")
    select today, from: 'inDate'
    click_button "絞り込み"
    expect(page).to have_link("#{@talent_user.name}")
  end
end

#docker-compose run web rspec spec/system/users_index_spec.rb