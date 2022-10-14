class Api::V1::CommentsController < ApplicationController
  before_action :require_user

  def create
    parent_comment = Comment.find(comment_params[:parent_id])
    # no nested comments atm
    if parent_comment.parent
      head :unprocessable_entity
    else
      new_comment = current_user.comments.build(comment_params)
      if new_comment.save
        head :created
      else
        head :unprocessable_entity
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:parent_id, :feedback_id, :content)
  end
end