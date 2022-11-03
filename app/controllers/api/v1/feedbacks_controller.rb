class Api::V1::FeedbacksController < ApplicationController
  before_action :require_user, only: [:create, :update, :destroy]
  before_action :set_feedback, only: [:update, :destroy]

  def index
    @feedbacks = Feedback.filter(filter_params)
    sort_params.each do |sort_by, order|
      @feedbacks = @feedbacks.public_send("sort_by_#{sort_by}", order)
    end
    @feedbacks = @feedbacks.page(params[:offset]).per(params[:limit])

    render json: {
      feedbacks: ActiveModel::SerializableResource.new(@feedbacks.includes(:user, :likes, likes: :user), each_serializer: FeedbackSerializer, scope: current_user).as_json,
      feedback_count:(if params[:category] == 'all' then Feedback.where(nil) else Feedback.where(category: params[:category]) end).count
    } 
  end

  def show
    @feedback = Feedback.find(params[:id])
    if @feedback
      render json: @feedback
      # render json: {
      #   feedback: ActiveModelSerializers::SerializableResource.new(@feedback, scope: {current_user}),
      #   # comments: ActiveModelSerializers::SerializableResource.new(@comments)
      # }
      # render json: @comments
    else
      head :not_found
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    if @feedback.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def create
    # current_user = User.first
    # feedback = current_user.feedbacks.build(feedback_params)
    # binding.irb
    
    # render json: feedback

    @feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      render json: @feedback, status: :created
    else
      head :unprocessable_entity
    end
  end
  
  def update
    if(@feedback.update(feedback_params))
      render json: @feedback, status: :created
    else
      head :unprocessable_entity
    end
  end
  
  private
    def feedback_params
      params.require(:feedback).permit(:title, :category, :status, :detail)
    end
    
    def filter_params
      params.slice(:category)
    end

    def sort_params
      JSON.parse(params[:sort])
    end

    def set_feedback
      @feedback = current_user.feedbacks.find(params[:id])
    end
end
