# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  describe 'user#show' do
    before do
      get api_v1_user_url(user.id), as: :json
    end
    it 'should show the user' do
      response.should be_success
      email = JSON.parse(response.body.with_indifferent_access.email)
      expect(email).to eq(user.email)
    end
  end
end
