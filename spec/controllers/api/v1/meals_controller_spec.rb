# frozen_string_literal: true

require 'rails_helper'

# spec/controllers/api/v1/meals_controller_spec.rb
RSpec.describe Api::V1::MealsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:meal) { Meal.create(name: 'Breakfast', user: user) }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

  before do
    request.headers[:Authorization] =
      JsonWebToken.encode(user_id: meal.user.id)
  end

  context 'get#show' do
    before do
      get :show, params: { id: meal.id }
    end
    it 'should show the meal with user logged in' do
      expect(response).to have_http_status(:success)
      expect(json_response.dig(:data, :attributes, :name)).to eq(meal.name)
    end

    it 'should also get user information' do
      expect(json_response.dig(:data, :relationships, :user, :data, :id)).to eq(meal.user.id.to_s)
      expect(json_response.dig(:included, 0, :attributes, :email)).to eq(meal.user.email)
    end
  end

  context 'get#index' do
    it 'should show all of the meals' do
      get :index, as: :json
      assert_response :success
    end
  end

  context 'post#create' do
    it 'should create a meal with proper params' do
      expect do
        post :create, params: { meal: {
          name: meal.name, user_id: meal.user.id, id: 15
        } }, as: :json
        expect(json_response.dig(:data, :attributes, :name)).to eq(meal.name)
      end.to change { user.meals.count }.by(1)
    end

    it 'should not create a meal without authorization' do
      request.headers[:Authorization] = nil
      expect do
        post :create, params: { meal:
              { name: meal.name, user_id: meal.user.id } }.as_json
      end.not_to change(user, :meals)
      expect(have_http_status(:forbidden))
    end
  end

  context 'patch#update' do
    it 'should update the meal' do
      patch :update, params: {
        id: meal.id, meal: { name: meal.name }
      }, as: :json
      expect(have_http_status('updated'))
    end

    it 'should not update the meal without authorization' do
      user2 = FactoryBot.create(:user, id: 2)
      request.headers[:Authorization] =
        JsonWebToken.encode(user_id: user2.id)
      patch :update, params: {
        id: meal.id, meal: { name: meal.name }
      }, as: :json
      expect(have_http_status(:forbidden))
    end
  end

  context 'delete#destroy' do
    it 'should delete the meal' do
      expect(
          delete(:destroy, params: { id: meal.id }, as: :json)
      ).to have_http_status(204)
    end

    it 'should not delete the recipe' do
      user2 = FactoryBot.create(:user, id: 2)
      request.headers[:Authorization] =
        JsonWebToken.encode(user_id: user2.id)
      expect(
        delete(:destroy, params: { id: meal.id }, as: :json)
      ).to have_http_status(:forbidden)
    end
  end
end
