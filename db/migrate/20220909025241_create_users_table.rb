class CreateUsersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :avatar_url

      t.timestamps
    end
  end
end
