# frozen_string_literal: true

module Api
  # API for user manipulation
  class UsersController < ApplicationController
    def index
      render json: User.all, except: %i[deleted_at password]
    end

    def show
      render json: User.find(params[:id]), except: %i[deleted_at password]
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    def create
      user = User.new(user_params)
      user.password = User.generate_password(user_params[:password])
      if user.save
        render json: user, except: %i[deleted_at password]
      else
        render json: user.errors, status: 422
      end
    end

    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: user, except: %i[deleted_at password]
      else
        render json: user.errors, status: 422
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    def destroy
      user = User.find(params[:id])
      user.soft_destroy

      render json: { message: 'User has been deleted' }.to_json, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :phone, :password)
    end
  end
end
