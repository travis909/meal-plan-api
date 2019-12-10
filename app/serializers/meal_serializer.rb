# frozen_string_literal: true

# app/serializers/meal_serializer.rb
class MealSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :date
  belongs_to :user
end
