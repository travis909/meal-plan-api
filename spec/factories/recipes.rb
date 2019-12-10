# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    directions { Faker::Food.description }
    servings { Faker::Number.decimal(l_digits: 2) }
    energy { Faker::Number.decimal(l_digits: 2) }
    carbs { Faker::Number.decimal(l_digits: 2) }
    fiber { Faker::Number.decimal(l_digits: 2) }
    sugar { Faker::Number.decimal(l_digits: 2) }
    fat { Faker::Number.decimal(l_digits: 2) }
    monounsaturated { Faker::Number.decimal(l_digits: 2) }
    polyunsaturated { Faker::Number.decimal(l_digits: 2) }
    omega3 { Faker::Number.decimal(l_digits: 2) }
    omega6 { Faker::Number.decimal(l_digits: 2) }
    saturated { Faker::Number.decimal(l_digits: 2) }
    transfat { Faker::Number.decimal(l_digits: 2) }
    cholesterol { Faker::Number.decimal(l_digits: 2) }
    protein { Faker::Number.decimal(l_digits: 2) }
    vit_b1 { Faker::Number.decimal(l_digits: 2) }
    vit_b2 { Faker::Number.decimal(l_digits: 2) }
    vit_b3 { Faker::Number.decimal(l_digits: 2) }
    vit_b5 { Faker::Number.decimal(l_digits: 2) }
    vit_b6 { Faker::Number.decimal(l_digits: 2) }
    vit_b12 { Faker::Number.decimal(l_digits: 2) }
    biotin { Faker::Number.decimal(l_digits: 2) }
    choline { Faker::Number.decimal(l_digits: 2) }
    folate { Faker::Number.decimal(l_digits: 2) }
    vit_a { Faker::Number.decimal(l_digits: 2) }
    vit_c { Faker::Number.decimal(l_digits: 2) }
    vit_d { Faker::Number.decimal(l_digits: 2) }
    vit_e { Faker::Number.decimal(l_digits: 2) }
    vit_k { Faker::Number.decimal(l_digits: 2) }
    calcium { Faker::Number.decimal(l_digits: 2) }
    chromium { Faker::Number.decimal(l_digits: 2) }
    copper { Faker::Number.decimal(l_digits: 2) }
    fluoride { Faker::Number.decimal(l_digits: 2) }
    iodine { Faker::Number.decimal(l_digits: 2) }
    iron { Faker::Number.decimal(l_digits: 2) }
    magnesium { Faker::Number.decimal(l_digits: 2) }
    manganese { Faker::Number.decimal(l_digits: 2) }
    molybdenum { Faker::Number.decimal(l_digits: 2) }
    phosphorus { Faker::Number.decimal(l_digits: 2) }
    potassium { Faker::Number.decimal(l_digits: 2) }
    selenium { Faker::Number.decimal(l_digits: 2) }
    sodium { Faker::Number.decimal(l_digits: 2) }
    zinc { Faker::Number.decimal(l_digits: 2) }

    association :user, factory: :user
  end
end
