# frozen_string_literal: true

# app/models/recipe.rb
class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  validates_presence_of :name, :user
end
