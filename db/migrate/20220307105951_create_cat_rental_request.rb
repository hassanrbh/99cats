# frozen_string_literal: true

class CreateCatRentalRequest < ActiveRecord::Migration[7.0]
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, null: false, default: 'PENDING'
      t.timestamps
    end
  end
end
