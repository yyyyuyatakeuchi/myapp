class User < ApplicationRecord
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed  # Include default devise modules. Others available are:
  has_one :talent_profile, dependent: :destroy
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
def follow(other_user)
  following << other_user 
end

def unfollow(other_user)
  relationships.find_by(followed_id: other_user.id).destroy
end

def following?(other_user)
  following.include?(other_user)
end

def update_resource(resource, params)
  resource.update_without_password(params)
end

  #before_save { self.email = email.downcase }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :name,  presence: true, length: { maximum: 30 }
  #validates :email, presence: true, length: { maximum: 150 },
  #                  format: { with: VALID_EMAIL_REGEX },
  #                  uniqueness: true
  #validates :password, presence: true, length: { minimum: 6 }
end
