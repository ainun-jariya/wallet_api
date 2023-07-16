# frozen_string_literal: true

module Api
  # API for session manipulation [login]
  class SessionsController < ApplicationController
    # method to verify / get profile user
    def index
      session = Session.where(token: session_params[:token]).first
      render json: { token: session.token, user: session.user }.to_json, except: %i[deleted_at password]
    rescue ActiveRecord::RecordNotFound, NoMethodError
      render json: { message: 'Session not found' }.to_json, status: 404
    end

    # method to create a session / login
    def create
      user = User.login(login_params[:email], login_params[:password])
      session = Session.create({ token: Session.generate_token(user), user_id: user.id, device: nil })
      if user.save
        render json: { token: session.token, user: user }.to_json, except: %i[deleted_at password]
      else
        render json: session.errors, status: 422
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }.to_json, status: 404
    end

    # method to delete a session / logout
    def destroy
      session = Session.find_by_token(session_params[:token])
      session.delete

      render json: { message: 'User has been signed out' }.to_json, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Session not found' }.to_json, status: 404
    end

    private

    def session_params
      params.require(:user).permit(:token)
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end
  end
end
