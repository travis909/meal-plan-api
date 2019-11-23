# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/recipes_controller.rb
    class RecipesController < ApplicationController
      def show
        render json: Recipe.find(params[:id])
      end

      def index
        render json: Recipe.all
      end
    end
  end
end
