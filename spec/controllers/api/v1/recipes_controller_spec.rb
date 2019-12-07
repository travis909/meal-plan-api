# frozen_string_literal: true

require 'rails_helper'

# spec/controllers/api/v1/recipes_controller_spec.rb
RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:json_response) { JSON.parse(response.body) }

  before do
    request.headers[:Authorization] =
      JsonWebToken.encode(user_id: recipe.user.id)
  end

  describe 'GET recipes' do
    it 'should show the recipe' do
      get :show, params: { id: recipe.id }
      expect(response).to have_http_status(:success)
      # testing symbolize_names convert others to this format
      j_response = JSON.parse(response.body, symbolize_names: true)
      expect(j_response.dig(:data, :attributes, :name)).to eq(recipe.name)
      expect(j_response.dig(:data, :relationships, :user, :data, :id)).to eq(recipe.user.id.to_s)
      expect(j_response.dig(:included, 0, :attributes, :email)).to eq(recipe.user.email)
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
          expect(json_response['data']['attributes']['name']).to eq(recipe.name)
        end.to change { user.recipes.count }.by(1)
      end
    end

    context 'should forbid recipe creation without authorization' do
      it 'should not create a recipe without authorization' do
        request.headers[:Authorization] = nil
        expect do
          post :create, params: { recipe: { name: recipe.name, user_id: recipe.user.id } }.as_json
        end.not_to change(user, :recipes)
        expect(have_http_status(:forbidden))
      end
    end
  end

  describe 'updating a recipe' do
    it 'should update the recipe' do
      patch :update, params: {
        id: recipe.id, recipe: { name: recipe.name }
      }, as: :json
      expect(have_http_status('updated'))
    end

    it 'should not update the recipe without authorization' do
      user2 = FactoryBot.create(:user, id: 2)
      request.headers[:Authorization] =
        JsonWebToken.encode(user_id: user2.id)
      patch :update, params: {
        id: recipe.id, recipe: { name: recipe.name }
      }, as: :json
      expect(have_http_status(:forbidden))
    end
  end

  describe 'deleting a recipe' do
    it 'should delete the recipe' do
      expect(
        delete(:destroy, params: { id: recipe.id }, as: :json)
      ).to have_http_status(204)
    end

    it 'should not delete the recipe' do
      user2 = FactoryBot.create(:user, id: 2)
      request.headers[:Authorization] =
        JsonWebToken.encode(user_id: user2.id)
      expect(
        delete(:destroy, params: { id: recipe.id }, as: :json)
      ).to have_http_status(:forbidden)
    end
  end
end
