require 'rails_helper'

RSpec.describe TalentProfile, type: :model do

  describe "user(芸人)と紐づくtalent_profile" do 
    let(:talent_user) { FactoryBot.create(:talent_user) }
    let(:talent_profile) { talent_user.create_talent_profile }

    it "user（芸人）に紐づけられたtalent_profileが有効なこと" do
      expect(talent_profile).to be_valid
    end

    it "user(芸人)に紐づくtalent_profileは一つのみ" do
      talent_profile2 = TalentProfile.new(user_id: talent_profile.user_id)
      expect(talent_profile2).to_not be_valid
    end
  end

  it "talent_profileはuser(芸人)と紐づいていない場合は無効" do
    new_talent_profile = TalentProfile.new
    expect(new_talent_profile).to_not be_valid
  end
end

#docker-compose run web rspec spec/models/talent_profile_spec.rb