# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Authenticable
end
