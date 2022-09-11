class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      render json: user
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

  def is_logged_in 
    render json: @current_user, status: :ok if logged_in?
  end 
end