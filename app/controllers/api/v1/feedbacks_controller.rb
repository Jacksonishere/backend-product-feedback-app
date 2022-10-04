class Api::V1::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.filter(filter_params)
    sort_params.each do |sort_by, order|
      feedbacks = feedbacks.public_send("sort_by_#{sort_by}", order)
    end
    feedbacks = feedbacks.page(params[:offset]).per(params[:limit])

    render json: feedbacks, include: [:user, :likes]
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

  def filter_params
    params.slice(:category)
  end

  def sort_params
    JSON.parse(params[:sort])
  end
end
