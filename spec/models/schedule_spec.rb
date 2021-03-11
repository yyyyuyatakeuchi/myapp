require 'rails_helper'

RSpec.describe Schedule, type: :model do

  describe "user(芸人)と紐づいたschedule" do
    let(:talent_user) { FactoryBot.create(:talent_user) }
    let(:schedule) {talent_user.schedules.create }
    
    it "user（芸人）に紐づけられたtalent_profileが有効なこと" do
      expect(schedule).to be_valid
    end
  end

  it "scheduleはuser(芸人)と紐づいていない場合は無効" do
    schedule = Schedule.new
    expect(schedule).to_not be_valid
  end
end

#docker-compose run web rspec spec/models/schedule_spec.rb
