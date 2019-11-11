# frozen_string_literal: true

class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :password_digest
  validates_format_of :email, with: /@/
end
