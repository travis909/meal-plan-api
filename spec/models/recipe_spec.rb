# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }

  context 'validations' do
    it 'should have a name' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end
  end
end
