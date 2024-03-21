class Restaurant < ApplicationRecord
	has_many :items
  belongs_to :user
  validates :owner_name, presence: true
  enum working_days: {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6
  }
end
