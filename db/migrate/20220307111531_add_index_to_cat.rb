# frozen_string_literal: true

class AddIndexToCat < ActiveRecord::Migration[7.0]
  def change
    add_index :cat_rental_requests, :cat_id
  end
end
