# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/meals_controller.rb
    class MealsController < ApplicationController
      before_action :set_meal, only: %i[show update destroy]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[update destroy]

      def index
        @meals = Meal.all
        render json: MealSerializer.new(@meals).serializable_hash
      end

      def show
        options = { include: %i[user recipe_ids] }
        render json: MealSerializer.new(@meal, options).serializable_hash
      end

      def create
        meal = current_user.meals.build(meal_params)
        if meal.save
          render json: MealSerializer.new(meal).serializable_hash, status: :created
        else
          render(json: { errors: meal.errors }, status:
              :unprocessable_entity)
        end
      end

      def update
        if @meal.update(meal_params)
          render json: MealSerializer.new(@meals).serializable_hash
        else
          render(json: { errors: current_user.meals.errors }, status:
              :unprocessable_entity)
        end
      end

      def destroy
        @meal.destroy
        head 204
      end

      private

      def meal_params
        params.require(:meal).permit(
          :name, :date
        )
      end

      def check_owner
        head :forbidden unless @meal.user.id == current_user&.id
      end

      def set_meal
        @meal = Meal.find(params[:id])
      end
    end
  end
end
