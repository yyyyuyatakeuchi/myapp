require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "entryのバリデーション" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create }
    let(:entry) { user.entries.create(room_id: room.id) }

    it "有効なentry" do
      expect(entry).to be_valid
    end

    it "user_idが空白の場合無効" do
      entry.user_id = nil
      expect(entry).to_not be_valid
    end

    it "room_idが空白の場合無効" do
      entry.room_id = nil
      expect(entry).to_not be_valid
    end

    it "user_idとroom_idの組合わせが同じだと無刻" do
      entry_again = Entry.new(user_id: entry.user_id, room_id: entry.room_id)
      expect(entry_again).to_not be_valid
    end

    it "user_idが異なれば同じroom_idが存在しても有効" do
      other_user = FactoryBot.create(:user)
      join_entry = Entry.new(user_id: other_user.id, room_id: entry.room_id)
      expect(join_entry).to be_valid
    end

    it "room_idが異なれば同じuser_idが存在しても有効" do
      entry
      other_room = Room.create
      other_entry = Entry.new(user_id: user.id, room_id: other_room.id)
      expect(other_entry).to be_valid
    end
  end
end

#docker-compose run web rspec spec/models/entry_spec.rb