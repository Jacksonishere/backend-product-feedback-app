class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: sign_in_params[:email].downcase)
    if user && user.authenticate(sign_in_params[:password])
      session[:current_user_id] = user.id
      render json: UserSerializer.new(user).serializable_hash.to_json
    else
      render json: { msg: 'Invalid credentials. Try again' }, status: :unauthorized
    end
  end

  def destroy
    if logged_in?
      session.delete(:current_user_id)
      render json: { msg: 'successfully logged out'}, status: :no_content
    else
      render json: { msg: 'you are not logged in' }, status: :unauthorized
    end
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end