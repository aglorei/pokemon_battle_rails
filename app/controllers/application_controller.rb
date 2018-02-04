class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActionController::ParameterMissing do |err|
    render json: { error: err.message.capitalize }, status: 400
  end
end
