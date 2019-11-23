# frozen_string_literal: true

# app/models/recipe.rb
class Recipe < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :user
end
