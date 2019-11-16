# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET user#show' do
    it 'should show the user' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['email']).to eq(user.email)
    end
  end

  describe 'POST user#create' do
    it 'should create a new user' do
      post :create, params: { user: { email: 'test@test.org', password: '123456' } }
      expect(JSON.parse(response.body)['status']).to eq('created')
    end
    it 'should not create user with the same email' do
      User.create(email: 'test@test.org', password: '123456')
      post :create, params: { user: { email: 'test@test.org', password: '123456' } }
      expect(JSON.parse(response.body)['errors']).to eq('unprocessable_entry')
    end
  end

  describe 'PATCH user#update' do
    it 'should update the users password' do
      patch :update, params: { id: user.id, user: { email: user.email, password: '123456' } }, as: :json
      expect(JSON.parse(response.body)['status']).to eq('updated')
    end
    it 'should not update the user with invalid params' do
      patch :update, params: { id: user.id, user: { email: 'bad_email', password: '123456' } }, as: :json
      expect(JSON.parse(response.body)['errors']).to eq('unprocessable_entry')
    end
  end

  describe 'should destroy the user' do
    it 'should delete the user' do
      new_user = FactoryBot.create(:user)
      delete :destroy, params: { id: new_user.id }, as: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
