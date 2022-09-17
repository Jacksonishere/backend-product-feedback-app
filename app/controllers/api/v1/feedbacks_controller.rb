class Api::V1::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.page(params[:offset]).per(params[:limit])
    # render json: FeedbackSerializer.new(feedbacks, include: [:user]).serializable_hash.to_json
    render json: feedbacks, include: [:user]
  end

  def show
    feedback = Feedback.find(params[:id])
    if feedback
      render json: feedback
    else
      head :not_found
    end
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
