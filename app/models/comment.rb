class Comment < ApplicationRecord
  validates :content, presence: true
  validate :no_nested_comment

  belongs_to :user
  belongs_to :feedback, counter_cache: :comments_count
  
  has_many :comments, foreign_key: :parent_id
  belongs_to :parent, class_name: 'Comment', optional: true

  private

  def no_nested_comment
    parent_comment = Comment.where(id: parent_id).first
    binding.irb
    errors.add("NO NESTED COMMENTS ATM!!!") if parent_comment && parent_comment.parent
  end
end
