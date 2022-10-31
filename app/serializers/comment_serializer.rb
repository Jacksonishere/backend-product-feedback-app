class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :parent_id, :created_at, :replies_count, :replied_to

  has_many :replies do
    object.replies.page(1).per(5)
  end
  belongs_to :user
end
