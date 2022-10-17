class AddRepliedToUsernameToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :replied_to, :string
  end
end
