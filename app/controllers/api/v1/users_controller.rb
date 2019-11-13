# frozen_string_literal: true

# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def show
    render json: User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render(json: { status: 'created' })
    else
      render(json: { errors: 'unprocessible_entry' })
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
