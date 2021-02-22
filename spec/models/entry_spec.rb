require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "entry with a user" do
    before do
      user = FactoryBot.create(:user)
      room = Room.create
      @entry = user.entries.create(room_id: room.id)
    end

    it "is valid with a user" do
      expect(@entry).to be_valid
    end

    it "is invalid without a user_id" do
      @entry.user_id = nil
      expect(@entry).to_not be_valid
    end

    it "is invalid without a room_id" do
      @entry.room_id = nil
      expect(@entry).to_not be_valid
    end

    it "is invalid with a user twice" do
      entry2 = Entry.new(user_id: @entry.user_id, room_id: @entry.room_id)
      expect(entry2).to_not be_valid
    end

    it "is valid entries, same room and different user" do
      other_user = FactoryBot.create(:user)
      join_entry = Entry.new(user_id: other_user.id, room_id: @entry.room_id)
      expect(join_entry).to be_valid
    end
  end
end

#docker-compose run web rspec spec/models/entry_spec.rb