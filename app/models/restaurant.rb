class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :offers, dependent: :destroy
  validates :owner_name, presence: true
end
