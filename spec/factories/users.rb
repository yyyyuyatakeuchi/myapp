FactoryBot.define do
  factory :user do
    name     {"テストユーザー"}
    address  {"tokyo"}
    confirmed_at {Time.now}
    isTalent {false}
    isPublic {false}
    admin    {false}
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }

    factory :talent_user do
      name     {"テスト芸人"}
      isTalent {true}
      isPublic {true}
    end
  end
end
