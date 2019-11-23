# frozen_string_literal: true

require 'rails_helper'

# spec/controllers/api/v1/recipes_controller_spec.rb
RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }

  describe 'GET user_recipe#show' do
    it 'should show the recipe' do
      get :show, params: { id: recipe.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(recipe.name)
    end

    it 'should show all recipes' do
      get :index, as: :json
      assert_response :success
    end
  end
end
