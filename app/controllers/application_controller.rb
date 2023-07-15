# frozen_string_literal: true

# a parent class for all controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
end
