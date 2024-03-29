class Item < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :offers, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true

  def average_rating
    reviews.average(:rating).to_f
  end
end
