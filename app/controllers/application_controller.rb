class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def current_user
    @current_user ||= User.find(sessions[:id]) if sessions[:id]
  end

  def logged_in?
    !!current_user
  end

  def parameter_missing(e)
   render json: { msg: e.message }, status: :unprocessable_entity
  end
end
