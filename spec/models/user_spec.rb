# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'valid user' do
    context 'email' do
      it 'should contain an email address' do
        user.email = nil
        expect(user).not_to be_valid
      end
      it 'should have an email with @' do
        user.email = 'testtest.com'
        expect(user).not_to be_valid
      end
      it 'should have a unique email' do
        (user1, user2 = FactoryBot.create(:user))
        expect(user2).to eq(nil)
      end
    end

    context 'password' do
      it 'should have a password' do
        user.password_digest = nil
        expect(user).not_to be_valid
      end
    end
  end
end
