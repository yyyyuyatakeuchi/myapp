require 'rails_helper'

RSpec.describe Relation, type: :model do
  describe "follow a user" do
    before do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:user)
      @relation = Relation.new(follower_id: user.id,
                          followed_id: other_user.id)
    end

    it "is valid with a user" do
      expect(@relation).to be_valid
    end

    it "is invalid without follower_id" do
      @relation.follower_id = nil
      expect(@relation).to_not be_valid
    end

    it "is invalid without followed_id" do
      @relation.followed_id = nil
      expect(@relation).to_not be_valid
    end
  end
end

#docker-compose run web rspec spec/models/relation_spec.rb
