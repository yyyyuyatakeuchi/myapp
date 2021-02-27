require 'rails_helper'

RSpec.describe "Mypage", type: :system do

  before do
    @talent_user = FactoryBot.create(:user, name: "aaa", address: "tokyo", isTalent: true, isPublic: true)
    @talent_user.create_talent_profile(character: "ピン芸人", free_write: "よろしく")
    @talent_user.schedules.create(availability: "◯", inDate: Time.zone.today.strftime, start_time: "#{Time.zone.today.strftime} 00:00:00")
  end

  scenario "一般ユーザーマイページ、アカウント情報編集" do
    sign_in @talent_user
    visit mypage_path(@talent_user)
    expect(page).to have_content("◯")
    click_link "編集", href: "/schedules/new?inDate=#{Time.zone.today.strftime}"
    expect(page).to have_content("×（厳しいです）")
    #find('label[for=schedule_×（厳しいです）]').click
    click_button "Update Schedule"
    expect(page).to have_content "以上"
    expect(page).to have_content "ー"
  end
end

#docker-compose run web rspec spec/system/calender_spec.rb