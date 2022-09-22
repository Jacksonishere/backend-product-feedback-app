class Api::V1::LikesController < ApplicationController
  before_action :require_user

  def update
    like = current_user.likes.where(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])[0]
    begin
      if like
        like.destroy!
      else
        current_user.likes.create!(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
      end
      head :no_content
    rescue
      head :unprocessable_entity
    end
  end
end
