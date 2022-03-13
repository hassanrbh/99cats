class AddIndexToUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :user_id
  end
end
