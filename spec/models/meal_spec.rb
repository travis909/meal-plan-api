require 'rails_helper'

RSpec.describe Meal, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:meal) { Meal.create(name: 'Breakfast', user: user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }

  context 'validations' do
    it 'should have a name' do
      meal.name = nil
      expect(meal).not_to be_valid
    end

    it 'should have a user' do
      expect(Meal.create(date: Date.today)).not_to be_valid
    end
  end

  context 'adding recipes' do
    it 'should be able to add recipes to meals' do
      recipe.meal_ids = meal.id
      expect(recipe.meal_ids).to eq([meal.id])
    end
  end
end
