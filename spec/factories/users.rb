# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { BCrypt::Password.create('g00d_pa$$') }
  end
end
