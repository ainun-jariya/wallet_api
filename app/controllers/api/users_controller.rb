# frozen_string_literal: true

module Api
  # API for user manipulation
  class UsersController < ApiController
    before_action :current_user, only: %i[show update destroy]
    before_action :find_user, only: %i[show update destroy]

    def index
      render json: User.all, except: %i[deleted_at password]
    end

    def show
      render json: @user, except: %i[deleted_at password]
    end

    def create
      @user = User.new(user_params)
      @user.password = User.generate_password(user_params[:password])
      if @user.save
        @user.wallet.save
        render json: user, except: %i[deleted_at password]
      else
        render json: @user.errors, status: 422
      end
    end

    def update
      if @user.update(user_params)
        render json: user, except: %i[deleted_at password]
      else
        render json: @user.errors, status: 422
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    def destroy
      @user.wallet.soft_destroy
      @user.soft_destroy

      render json: { message: 'User has been deleted' }.to_json, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    private

    def find_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone, :password)
    end
  end
end
