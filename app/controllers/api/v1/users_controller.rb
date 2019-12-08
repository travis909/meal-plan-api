# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/users_controller.rb
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]
      before_action :check_owner, only: %i[update destroy]

      # GET /users/1
      def show
        options = { include: [:recipes] }
        render json: UserSerializer.new(@user, options).serializable_hash
      end

      # POST /users/1
      def create
        @user = User.new(user_params)
        if @user.save
          render json: UserSerializer.new(@user).serializable_hash,
                 status: :created
        else
          render(json: { errors: 'unprocessable_entry' })
        end
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: UserSerializer.new(@user).serializable_hash
        else
          render(json: { errors: 'unprocessable_entry' })
        end
      end

      # DELETE /users/1
      def destroy
        @user.destroy
        head 204
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def check_owner
        head :forbidden unless @user.id == current_user&.id
      end
    end
  end
end
