require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:talent_user) { FactoryBot.create(:talent_user) }

  it "factoryBotが有効かどうか" do
    expect(user).to be_valid
  end

  describe "各属性のバリデーション" do

    describe "name属性のバリデーション" do
      it "空白は無効" do
        user = FactoryBot.build(:user, name: "")
        expect(user).to_not be_valid
      end

      it "1文字以上は有効" do
        user = FactoryBot.build(:user, name: "あ")
        expect(user).to be_valid
      end

      it "50文字は有効" do
        user = FactoryBot.build(:user, name: "#{"あ"*50}")
        expect(user).to be_valid
      end

      it "51文字以上は無効" do
        user = FactoryBot.build(:user, name: "#{"あ"*51}")
        expect(user).to_not be_valid
      end
    end

    describe "email属性のバリデーション" do
      it "空白は無効" do
        user = FactoryBot.build(:user, email: "")
        expect(user).to_not be_valid
      end

      it "同じメールアドレスは登録できない" do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.build(:user, email: user.email)
        expect(other_user).to_not be_valid
      end
    end

    describe "password属性のバリデーション" do
      it "空白は無効" do
        user = FactoryBot.build(:user, password: "")
        expect(user).to_not be_valid
      end
    end
  end

  describe "フォローメソッドのテスト" do
    it "following?メソッドでtalent_userをフォローしているか確認できる" do
      user.following << talent_user
      expect(user.following?(talent_user)).to be true 
    end

    it "followメソッドでtalent_userをフォローできる" do
      user.follow(talent_user)
      expect(user.following?(talent_user)).to be true 
    end

    it "unfollowメソッドでtalent_userのフォローを外せる" do
      user.follow(talent_user)
      user.unfollow(talent_user)
      expect(user.following?(talent_user)).to_not be true 
    end
  end
end

#docker-compose run web rspec spec/models/user_spec.rb