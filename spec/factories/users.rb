FactoryBot.define do
  factory :user do
    name     {"Michael Hartl"}
    email    {"michael@example.com"}
    address {}
    isTalent {}
    isPublic {}
    admin {}
  end
end
