class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :body, presence: true
end
