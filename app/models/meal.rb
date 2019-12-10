# frozen_string_literal: true

# app/models/meal.rb
class Meal < ApplicationRecord
  has_many :recipes
  belongs_to :user
  validates_presence_of :name, :user
end
