class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :parent_id, :created_at

  has_many :comments
  belongs_to :user
end
