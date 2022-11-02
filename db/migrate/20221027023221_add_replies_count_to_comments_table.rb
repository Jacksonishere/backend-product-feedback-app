class AddRepliesCountToCommentsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :replies_count, :integer, :default => 0
  end
end
