class Item < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  validates :name, presence: true
end
