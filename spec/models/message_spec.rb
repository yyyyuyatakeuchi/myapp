require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "message with a user" do
    before do
      user = FactoryBot.create(:user)
      room = Room.create
      @message = user.messages.create(room_id: room.id, body: "hello")
    end

    it "is valid message" do
      expect(@message).to be_valid
    end

    it "is invalid without body" do
      @message.body = ""
      expect(@message).to_not be_valid
    end

    it "is invalid without user_id" do
      @message.user_id = nil
      expect(@message).to_not be_valid
    end

    it "is invalid without rom_id" do
      @message.room_id = nil
      expect(@message).to_not be_valid
    end
  end
end

#docker-compose run web rspec spec/models/message_spec.rb