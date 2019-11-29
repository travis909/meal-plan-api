# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/recipes_controller.rb
    class RecipesController < ApplicationController
      before_action :set_recipe, only: %i[show update destroy]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[update destroy]

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

      def update
        if @recipe.update(recipe_params)
          render(json: { recipe: current_user.recipes.find(params[:id]), status: 'updated' })
        else
          render(json: { errors: current_user.recipes.errors }, status:
              :unprocessable_entity)
        end
      end

      def destroy
        @recipe.destroy
        head 204
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

      def check_owner
        head :forbidden unless @recipe.user.id == current_user&.id
      end

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end
    end
  end
end
