# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/recipes_controller.rb
    class RecipesController < ApplicationController
      before_action :check_login, only: %i[create]

      def show
        render json: Recipe.find(params[:id])
      end

      def index
        render json: Recipe.all
      end

      def create
        recipe = current_user.recipes.build(recipe_params)
        if recipe.save
          render(json: { recipe: recipe, status: 'created' })
        else
          render(json: { errors: recipe.errors }, status:
              :unprocessable_entity)
        end
      end

      private

      def recipe_params
        params.require(:recipe).permit(
          :name, :directions, :servings, :energy, :carbs,
          :fiber, :sugar, :fat, :monounsaturated, :polyunsaturated,
          :omega3, :omega6, :saturated, :transfat, :cholesterol,
          :protein, :vit_b1, :vit_b2, :vit_b3, :vit_b5, :vit_b6,
          :vit_b12, :biotin, :choline, :folate, :vit_a, :vit_c,
          :vit_d, :vit_e, :vit_k, :calcium, :chromium, :copper,
          :fluoride, :iodine, :iron, :magnesium, :manganese, :molybdenum,
          :phosphorus, :potassium, :selenium, :sodium, :zinc
        )
      end
    end
  end
end
