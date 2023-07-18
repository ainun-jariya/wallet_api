# frozen_string_literal: true

# a parent class for all controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    return redirect_to new_session_path if session[:current_user_id].nil?

    user = User.find(session[:current_user_id])
    @current_user = user
  rescue ActiveRecord::RecordNotFound, NoMethodError
    @current_user = User.first
    redirect_to new_session_path
  end
end
