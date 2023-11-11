class AuthenticationController < ApiController
  skip_before_action :verify_token
  skip_before_action :verify_authenticity_token

  def login
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      render json: { token: JsonWebToken.encode(user_id: user.id) }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
