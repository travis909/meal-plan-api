# frozen_string_literal: true

# app/serializers/user_serializer.rb
class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email
end
