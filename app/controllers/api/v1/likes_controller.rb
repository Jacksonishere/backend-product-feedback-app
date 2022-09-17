class Api::V1::LikesController < ApplicationController
  before_action :require_user

  def create
    like = current_user.likes.build(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type]);
    if like.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  def destroy
    like = Like.where(likeable_type: params[:likeable_type], likeable_id: params[:likeable_id])[0] 
    if like.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end
end
