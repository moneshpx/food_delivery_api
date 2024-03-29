class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant,optional: true
  belongs_to :item,optional: true
  validates :rating, presence: true
  validates_uniqueness_of :user_id, scope: [:item_id, :restaurant_id], message: "User can only review an item or restaurant once."
end
