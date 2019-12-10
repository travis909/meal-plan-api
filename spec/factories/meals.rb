# frozen_string_literal: true

FactoryBot.define do
  factory :meal do
    name { Faker::Food.dish }
    date { Date.today }
    recipe_ids { nil }

    association :user, factory: :user
  end
end
