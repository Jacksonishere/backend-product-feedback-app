class AddCommentsCountToFeedbacks < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :comments_count, :integer
  end
end
