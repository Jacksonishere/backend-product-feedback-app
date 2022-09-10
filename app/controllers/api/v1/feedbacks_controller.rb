class Api::V1::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.all
    render json: FeedbackSerializer.new(feedbacks, include: [:user]).serializable_hash.to_json
  end

  def show

  end

  def destroy
  
  end

  def update

  end
end
