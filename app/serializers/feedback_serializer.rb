class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :title, :detail, :category, :status, :updated_at

  belongs_to :user
  has_many :likes, as: :likeable
  # object refers to the current object being serialized
  def updated_at
    object.updated_at.strftime("%d %b %Y")
  end

  def likes
    object.likes.count
  end
  
end
