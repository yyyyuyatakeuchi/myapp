require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe "schedule with a user" do
    before do
      user = FactoryBot.create(:user)
      @schedule = user.schedules.create
    end

    it "is valid with a user" do
      expect(@schedule).to be_valid
    end
  end

  it "is invalid without a user, schedule" do
    schedule = Schedule.new
    expect(schedule).to_not be_valid
  end
end

#docker-compose run web rspec spec/models/schedule_spec.rb
