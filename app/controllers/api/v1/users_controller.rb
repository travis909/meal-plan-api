# frozen_string_literal: true

# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # GET /users/1
  def show
    render json: User.find(params[:id])
  end

  # POST /users/1
  def create
    @user = User.new(user_params)
    if @user.save
      render(json: { status: 'created' })
    else
      render(json: { errors: 'unprocessable_entry' })
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render(json: { status: 'updated' })
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
end
