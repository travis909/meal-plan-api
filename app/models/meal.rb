class Meal < ApplicationRecord
  has_many :recipes
  belongs_to :user

  validates_presence_of :name, :user
end
