FactoryBot.define do
  factory :meal do
    name { Faker::Food::dish }
    date { Faker::Date }
    association :user, factory: :user
  end
end
