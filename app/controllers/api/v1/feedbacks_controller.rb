class Api::V1::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.page(params[:page_num] || 1).per(15)
    render json: { feedbacks: FeedbackSerializer.new(feedbacks, include: [:user]).serializable_hash }.to_json
  end

  def show

  end

  def destroy
  
  end

  def update

  end
  
  def create
    
  end

  def feedback_params
    # params.permit(:page_num)
  end
end
