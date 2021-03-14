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
         :recoverable, :rememberable, :validatable,
         :confirmable
         #:omniauthable, omniauth_providers: [:twitter]

  #def self.from_omniauth(auth)
  #  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #    user.provider = auth.provider
  #    user.uid = auth.uid
  #    user.name = (auth.provider == 'twitter' ? auth.info.nickname : auth.name)
  #    user.email = User.dummy_email(auth)
  #    user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
  #  end
  #end

  #def self.dummy_email(auth)
  #  "#{auth.uid}-#{auth.provider}@example.com"
  #end

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
