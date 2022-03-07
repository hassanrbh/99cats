# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
    STATUS_CHOICES = [
        "APPROVED",
        "DENIED"
    ]
    validates_presence_of :cat_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates :status, presence: true, inclusion: {
        in: STATUS_CHOICES,
        message: 'must be Still PENDING'
    }

    # ! Association Between Catrental and CAT
    belongs_to :cat,
        class_name: 'Cat',
        primary_key: :id,
        foreign_key: :cat_id,
        dependent: :destroy
end
