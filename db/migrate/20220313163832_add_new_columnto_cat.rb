class AddNewColumntoCat < ActiveRecord::Migration[7.0]
  def change
    add_column :cats, :user_id, :integer
  end
end
