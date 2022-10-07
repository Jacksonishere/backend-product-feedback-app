class Api::V1::FeedbacksController < ApplicationController
  # before_action :require_user, only: [:create, :update, :destroy]

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

  def create
    # current_user = User.first
    # feedback = current_user.feedbacks.build(feedback_params)
    # binding.irb
    
    # render json: feedback

    feedback = current_user.feedbacks.build(feedback_params)
    if feedback.save
      render json: feedback, status: :created
    else
      head :unprocessable_entity
    end
  end

  def update

  end

  def feedback_params
    params.require(:feedback).permit(:title, :category, :status, :detail)
  end
  
  def filter_params
    params.slice(:category)
  end

  def sort_params
    JSON.parse(params[:sort])
  end
end
