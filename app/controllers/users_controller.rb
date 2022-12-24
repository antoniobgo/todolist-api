# frozen_string_literal: true

class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  skip_before_action :authorized, only: [:create]
  # before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  # def show
  #   render json: @user, status: 200
  # end

  def create
    @user = User.create!(user_params)
    @token = encode_token(user_id: user.id)
    render json: {
      user: @user.as_json(only: [:email]),
      token: @token
    }, status: :created
  end

  # def update
  #   unless @user.update(user_params)
  #     render json: {errors: @user.errors._full_messages }, status: 503
  # end

  # def destroy
  #   @user.destroy
  # end

  def me
    render json: {user: current_user.as_json(only: [:email])}, status: :ok
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def handle_invalid_record(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
