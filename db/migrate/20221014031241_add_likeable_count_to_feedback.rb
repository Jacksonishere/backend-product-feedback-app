class AddLikeableCountToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :likeable_count, :integer
  end
end
