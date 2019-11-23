# frozen_string_literal: true

require 'rails_helper'

class MockController
  include Authenticable
  attr_accessor :request
  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

RSpec.describe 'Authentication', type: :controller do
  let(:json_response) { JSON.parse(response.body) }
  let(:user) { FactoryBot.create(:user) }
  let(:authentication) { MockController.new }

  describe 'GET current_user' do
    it 'should get user from Authorization token' do
      authentication.request.headers['Authorization'] =
        JsonWebToken.encode(user_id: user.id)
      expect(user.id).to eq(authentication.current_user.id)
    end

    it 'should not get user from empty Authorization token' do
      authentication.request.headers['Authorization'] = nil
      assert_nil authentication.current_user
    end
  end
end
