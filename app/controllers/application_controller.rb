class ApplicationController < ActionController::API
  # serialization_scope :view_context

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    head :unauthorized if !logged_in? 
  end

  def parameter_missing(e)
    render json: { msg: e.message }, status: :unprocessable_entity
  end

  def record_not_found
    head :not_found
  end
end
