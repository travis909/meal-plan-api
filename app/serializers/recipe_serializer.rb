# frozen_string_literal: true

# app/serializers/recipe_serializer.rb
class RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :directions, :servings, :energy, :carbs, :fiber, :sugar,
             :fat, :monounsaturated, :polyunsaturated, :omega3, :omega6,
             :saturated, :transfat, :cholesterol, :protein, :vit_b1, :vit_b2,
             :vit_b3, :vit_b5, :vit_b6, :vit_b12, :biotin, :choline, :folate,
             :vit_a, :vit_c, :vit_d, :vit_e, :vit_k, :calcium, :chromium,
             :copper, :fluoride, :iodine, :iron, :magnesium, :manganese,
             :molybdenum, :phosphorus, :selenium, :sodium, :zinc
  
  belongs_to :user
end
