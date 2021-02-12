class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  has_many :relations, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relations, source: :followed 
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :schedules, dependent: :destroy
  #has_many :rooms, through: :entries
  # Include default devise modules. Others available are:
  has_one :talent_profile, dependent: :destroy
  accepts_nested_attributes_for :talent_profile

  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def follow(other_user)
    following << other_user 
  end

  def unfollow(other_user)
    relations.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
