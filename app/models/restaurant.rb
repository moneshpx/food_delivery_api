class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :owner_name, presence: true

  def average_rating
    reviews.average(:rating).to_f
  end
end
