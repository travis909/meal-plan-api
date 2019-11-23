# frozen_string_literal: true

require 'rails_helper'

# spec/controllers/api/v1/recipes_controller_spec.rb
RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }

  before do
    request.headers[:Authorization] =
      JsonWebToken.encode(user_id: recipe.user.id)
  end

  describe 'GET recipes' do
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

  describe 'creating recipes' do
    context 'should create a recipe' do
      it 'should create a recipe with proper params' do
        expect do
          post :create, params: { recipe: {
            name: recipe.name, user_id: recipe.user.id, id: 15
          } }, as: :json
        end.to change { user.recipes.count }.by(1)

        expect(JSON.parse(response.body)['status']).to eq('created')
      end
    end

    context 'should not create a recipe' do
      it 'should not create a recipe without authorization' do
        request.headers[:Authorization] = nil
        expect do
          post :create, params: { recipe: { name: recipe.name, user_id: recipe.user.id } }.as_json
        end.not_to change(user, :recipes)

        expect(have_http_status(:forbidden))
      end
    end
  end
end
