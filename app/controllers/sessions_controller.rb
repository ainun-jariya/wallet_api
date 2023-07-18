# frozen_string_literal: true

# login / logout controller
class SessionsController < ApplicationController
  before_action :current_user, only: %i[destroy]

  def new; end

  def create
    user = User.login(login_params[:email], login_params[:password])
    sessionn = Session.new({ token: Session.generate_token(user), user_id: user.id, device: nil })
    if sessionn.save
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to new_session_path
  end

  def destroy
    sessionn = @current_user.sessions.first # next time, find by device id
    sessionn.delete
    session[:current_user_id] = nil

    render json: { message: 'User has been signed out' }.to_json, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Session not found' }.to_json, status: 404
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
