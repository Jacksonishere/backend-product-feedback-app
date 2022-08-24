class Api::V1::UsersController < ApplicationController
  # GET /api/v1/users
  def index
    users = User.all

    render json: api_v1_users
  end

  # GET /api/v1/users/1
  def show
    user = User.find(params[:id])
    
    render json: user
  end

  # POST /api/v1/users
  def create
    new_user = User.new(create_params)

    if new_user.save
      session[:current_user_id] = new_user.id
      render json: UserSerializer.new(new_user).serializable_hash, status: :created
    else
      render json: { msg: new_user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end 

  # def base_params
  #   params.require(:user)
  # end
  
  # # PATCH/PUT /api/v1/users/1
  # def update
  #   if @api_v1_user.update(api_v1_user_params)
  #     render json: @api_v1_user
  #   else
  #     render json: @api_v1_user.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /api/v1/users/1
  # def destroy
  #   @api_v1_user.destroy
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_api_v1_user
  #     @api_v1_user = Api::V1::User.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def api_v1_user_params
  #     params.fetch(:api_v1_user, {})
  #   end
end
