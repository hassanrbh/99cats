# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
    CATS_COLORS = [
        "Black",
        "Red",
        "Green",
        "Yellow",
        "White",
        "Silver",
        "Black Smiko"
    ]
    CAT_SEX = [
        "F",
        "M"
    ]
    validates :birth_date, presence: true
    validates :color, presence: true, inclusion: {
        in: CATS_COLORS,
        message: "you choose is not supported"
    }
    validates :name, presence: true
    validates :sex, presence: true, inclusion: {
        in: CAT_SEX,
        message: "you shoose is not supported, if your cat gay pliz contact 911 :)"
    }
    validates :description, presence: true

    def age
        # Time.zone.now.year - birth_date.year, This trick is works to months
        ((Time.zone.now - birth_date.to_time) / 1.year.seconds ).floor
    end

    # ! Association Between CAT and Catrental
    has_many :cat_rental_requests,
        class_name: 'CatRentalRequest',
        primary_key: :id,
        foreign_key: :cat_id,
        dependent: :destroy
end
