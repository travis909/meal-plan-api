# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #create' do
    it 'returns http success' do
      post :create, params: { id: user.id, user: {
        email: user.email,
        password: 'g00d_pa$$'
      } }, as: :json

      expect(response).to have_http_status(:success)
      expect(json_response['token']).not_to be(nil)
    end
    it 'returns http forbidden' do
      post :create, params: { id: user.id, user: {
        email: user.email,
        password: 'bad_password'
      } }, as: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
