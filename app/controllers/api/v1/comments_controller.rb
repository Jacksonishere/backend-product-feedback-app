class Api::V1::CommentsController < ApplicationController
  before_action :require_user, only: [:create]

  def parent_comments 
    # get parent comments for the specific feedback
    @comments = Comment.where(feedback: params[:feedback_id])
                       .where(parent_id: nil)
                       .order(created_at: :desc)
                       .page(params[:offset])
                       .per(params[:limit])
                       .includes(:replies, :user)
    render json: @comments
  end

  def replies
    @comments = Comment.find(params[:parent_id])
                       .replies.page(params[:offset])
                       .per(params[:limit])
    render json: @comments
  end

  # cases
  # 1. brand new comment
  # 2. replying to an exist comment
  # 3. replying to a reply
  # 4. someone trying to tamper with system using external requests
  def create
    # A reply
    if(comment_params[:parent_id])
      parent_comment = Comment.find(comment_params[:parent_id])
      new_comment = parent_comment.replies.build(comment_params)
    else
      new_comment = current_user.comments.build(comment_params)
    end

    if new_comment.save
      render json: new_comment
    else
      head :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:parent_id, :feedback_id, :content, :replied_to).merge(user_id: current_user.id)
  end
end