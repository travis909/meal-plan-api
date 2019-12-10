# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :password_digest
  validates_format_of :email, with: /@/

  has_secure_password
  has_many :recipes, dependent: :destroy
  has_many :meals, dependent: :destroy
end