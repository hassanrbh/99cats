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
    
    # This functionality will make any user can approve or deny a cat's catrentalrequest
    # * Rule 1: when approving a cat rental and set their status to APPROVED , all the other catrental requests that belongs_to the same cat will DENIED
    def overlapping_pending_requests
        overlapping_requests.where(:status => "PENDING")
    end
    def approve!
        # change the current instance status from 'PENDING' to 'APPROVED'
        raise "still pending" unless self.status = "PENDING"
        unless self.status == "APPROVED"
            self.status = "APPROVED"
            self.save! 
            self.overlapping_pending_requests.transaction do |pending_request|
                # also we can use update! instaead of this crappy methods 
                # pending_request.status = "DENIED"
                # pending_request.save!
                pending_request.update!(:status => "DENIED")
            end
        else
            self.errors.add(:status,"you already #{self.status}")
        end
    end
    def deny!
        unless self.status == "DENIED"
            self.status = "DENIED"
            self.save!
        else
            self.errors.add(:status, "already DENIED")
        end
    end
    def pending?
        self.status == 'PENDING'
    end
end
