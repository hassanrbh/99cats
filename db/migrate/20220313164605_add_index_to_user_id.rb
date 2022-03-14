# frozen_string_literal: true

class AddIndexToUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :cats, :user_id
  end
end
