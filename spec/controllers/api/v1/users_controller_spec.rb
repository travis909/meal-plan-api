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
      user_count = User.count
      post :create, params: { user: { email: 'test@test.org', password: '123456' } }
      expect(User.count).to eq(user_count + 1)
      expect(JSON.parse(response.body)['status']).to eq('created')
    end
    it 'should not create user with the same email' do
      User.create(email: 'test@test.org', password: '123456')
      user_count = User.count
      post :create, params: { user: { email: 'test@test.org', password: '123456' } }
      expect(User.count).to eq(user_count)
      expect(JSON.parse(response.body)['errors']).to eq('unprocessible_entry')
    end
  end
end
