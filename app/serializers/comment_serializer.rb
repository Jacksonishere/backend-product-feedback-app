class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :parent_id, :created_at

  has_many :comments do
    object.comments.page(1).per(5)
  end
  belongs_to :user
end
