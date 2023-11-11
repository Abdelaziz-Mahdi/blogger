class ApiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :verify_token
  protect_from_forgery with: :null_session

  private

  def verify_token
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
