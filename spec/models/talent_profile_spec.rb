require 'rails_helper'

RSpec.describe TalentProfile, type: :model do

  describe "talent_profile with a user" do
    before do
      user = FactoryBot.create(:user)
      @talent_profile = user.create_talent_profile
    end

    it "is valid with a user" do
      expect(@talent_profile).to be_valid
    end

    it "is invalid with a user twice" do
      talent_profile2 = TalentProfile.new(user_id: @talent_profile.user_id)
      expect(talent_profile2).to_not be_valid
    end
  end

  it "is invalid without a user, talent_profile" do
    talent_profile = TalentProfile.new
    expect(talent_profile).to_not be_valid
  end
end

#docker-compose run web rspec spec/models/talent_profile_spec.rb