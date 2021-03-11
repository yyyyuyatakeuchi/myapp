require 'rails_helper'

RSpec.describe Relation, type: :model do
  describe "Relationのバリデーション" do
    let(:user) { FactoryBot.create(:user) }
    let(:talent_user) { FactoryBot.create(:talent_user) }
    let(:relation) { Relation.new(follower_id: user.id,
                        followed_id: talent_user.id)}

    it "follower_id,followed_id共に有効な値が入っている場合は有効" do
      expect(relation).to be_valid
    end

    it "follower_idが空の場合無効" do
      relation.follower_id = nil
      expect(relation).to_not be_valid
    end

    it "followed_idが空の場合無効" do
      relation.followed_id = nil
      expect(relation).to_not be_valid
    end
  end
end

#docker-compose run web rspec spec/models/relation_spec.rb
