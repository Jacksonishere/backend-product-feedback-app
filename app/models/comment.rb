class Comment < ApplicationRecord
  validates :content, presence: true
  validate :no_nested_comment

  belongs_to :user
  belongs_to :feedback, counter_cache: :comments_count
  
  # has pk assumed to be (self_id)comment_id in :comments table
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  # has pk assumed to be parent_id that points to :parent table by default
  belongs_to :parent, class_name: 'Comment', optional: true, counter_cache: :replies_count

  private

  def no_nested_comment
    parent_comment = Comment.where(id: parent_id).first
    errors.add("NO NESTED COMMENTS ATM!!!") if parent_comment && parent_comment.parent
  end
end
