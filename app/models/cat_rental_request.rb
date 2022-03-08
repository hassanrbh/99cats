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
        "DENIED",
        "PENDING"
    ].freeze
    validates_presence_of :cat_id
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true, inclusion: {
        in: STATUS_CHOICES
    }
    # ! Association Between Catrental and CAT
    validate(:does_not_overlap_approved_request)
    belongs_to :cat,
        class_name: 'Cat',
        primary_key: :id,
        foreign_key: :cat_id,
        dependent: :destroy
        
    def overlapping_requests
    CatRentalRequest
        .where.not(:id => self.id)
        .where(:cat_id => cat_id)
        .where.not('start_date > :end_date OR end_date < :start_date',
                start_date: start_date, end_date: end_date)
    end
    def overlapping_approved_requests
        overlapping_requests.where(:status => "APPROVED")
    end
    def does_not_overlap_approved_request
        overlapping_approved_requests.exists?
    end
end
