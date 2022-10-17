class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :title, :detail, :category, :status, :updated_at, :num_likes, :num_comments, :user_liked

  belongs_to :user
  has_many :comments do
    object.comments.where(parent_id: nil).includes(:user, comments: [:comments, :user])
  end
  # has_many :likes, as: :likeable
  
  # object refers to the current object being serialized
  def updated_at
    object.updated_at.strftime("%d %b %Y")
  end

  def num_likes
    object.likeable_count
  end

  def num_comments
    object.comments_count
  end

  def user_liked
    if current_user 
      object.likes.where(user: current_user).count == 1
    else
      false
    end
  end
  
end
