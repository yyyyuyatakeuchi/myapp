class Schedule < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  enum availability: {ー:0, ◯:1, △:2, ×:3}
end
