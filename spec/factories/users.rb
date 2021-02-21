FactoryBot.define do
  factory :user do
    name     {"Michael Hartl"}
    address  {"tokyo"}
    isTalent {false}
    isPublic {false}
    admin    {false}
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }
  end
end
