# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET user#show' do
    it 'should show the user' do
      user.recipes.create(name: 'New Recipe', id: 1)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(json_response.dig(:data, :attributes, :email)).to eq(user.email)
      expect(json_response.dig(:data, :relationships, :recipes, :data, 0, :id)).to eq(user.recipes.first.id.to_s)
      expect(json_response.dig(:included, 0, :attributes, :name)).to eq(user.recipes.first.name.to_s)       
    end
  end

  describe 'POST user#create' do
    it 'should create a new user' do
      post :create, params: { user: {
        email: 'test@test.org', password: '123456'
      } }.as_json

      expect(response).to have_http_status(201)
    end
    it 'should not create user with the same email' do
      User.create(email: 'test@test.org', password: '123456')
      post :create, params: { user: {
        email: 'test@test.org', password: '123456'
      } }.as_json

      expect(json_response.dig(:errors)).to eq('unprocessable_entry')
    end
  end

  describe 'PATCH user#update' do
    context 'it should update the user' do
      it 'should update the users with valid params' do
        request.headers[:Authorization] = JsonWebToken.encode(user_id: user.id)
        patch :update,
              params: { id: user.id, user: {
                email: 'updated_email@email.com', password: '123456'
              } }, as: :json

        expect(json_response.dig(:data, :attributes, :email)).to eq('updated_email@email.com')
      end
    end

    context 'it should not update the user' do
      it 'should not update the user with invalid params' do
        request.headers[:Authorization] = JsonWebToken.encode(user_id: user.id)
        patch :update, params: { id: user.id, user: {
          email: 'bad_email', password: '123456'
        } }.as_json
        expect(json_response.dig(:errors)).to eq('unprocessable_entry')
      end
    end
  end

  describe 'DELETE user#destroy' do
    context 'it should delete the user' do
      it 'should delete the user' do
        new_user = FactoryBot.create(:user)
        request.headers[:Authorization] = JsonWebToken.encode(user_id: new_user.id)
        delete :destroy, params: { id: new_user.id }, as: :json
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'it should not delete the user' do
      it 'should not delete the user' do
        new_user = FactoryBot.create(:user)
        delete :destroy, params: { id: new_user.id }, as: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'DELETE user#destroy should destroy recipe' do
      it 'should delete the user and the linked recipes' do
        recipe1 = FactoryBot.create(:recipe, user: user)
        total_recipes = Recipe.count
        user.destroy
        expect(Recipe.count).to eq(total_recipes - 1)
      end
    end
  end
end
