class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant,optional: true
  belongs_to :item,optional: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates_uniqueness_of :user_id, scope: [:item_id, :restaurant_id], message: "User can only review an item or restaurant once."
end
