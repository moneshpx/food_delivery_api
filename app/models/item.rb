class Item < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :offers, dependent: :destroy
  validates :name, presence: true
end
