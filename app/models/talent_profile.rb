class TalentProfile < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true, uniqueness: { scope: :user_id }
end
