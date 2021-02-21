require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a first name, last name and email, and password" do
    user = User.new(
      name: "Aaron",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end

  it "is valid with a name" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid with a name" do
    user = FactoryBot.build(:user, name: "")
    expect(user).to_not be_valid
  end

  it "following? other_user" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    user.following << other_user
    expect(user.following?(other_user)).to be true 
  end

  it "follow other_user" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    user.follow(other_user)
    expect(user.following?(other_user)).to be true 
  end

  it "unfollow other_user" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    user.follow(other_user)
    user.unfollow(other_user)
    expect(user.following?(other_user)).to_not be true 
  end

end

#docker-compose run web rspec spec/models/user_spec.rb