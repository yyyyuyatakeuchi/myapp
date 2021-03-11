require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "messageのバリデーション" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create }
    let(:message) { user.messages.create(room_id: room.id, body: "hello")}
    
    it "有効なメッセージ" do
      expect(message).to be_valid
    end

    it "body属性が空白の場合無効" do
      message.body = ""
      expect(message).to_not be_valid
    end

    it "user_id属性が空白の場合無効" do
      message.user_id = nil
      expect(message).to_not be_valid
    end

    it "room_id属性が空白の場合無効" do
      message.room_id = nil
      expect(message).to_not be_valid
    end
  end
end

#docker-compose run web rspec spec/models/message_spec.rb