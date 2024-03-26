class Offer < ApplicationRecord
  belongs_to :restaurant
  belongs_to :item,optional: true
  belongs_to :category,optional: true
end
