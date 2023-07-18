# frozen_string_literal: true

# a parent class for all API controller
class ApiController < ApplicationController
  def current_user
    return render json: 'No token provided', status: 401 if request.headers['Authorization'].nil?

    session = Session.find_by_token(request.headers['Authorization'])
    @current_user = session.user
  rescue ActiveRecord::RecordNotFound, NoMethodError
    render json: 'User not found', status: 401
  end
end
