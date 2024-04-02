class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  enum status: [:pending, :ongoing, :shipped, :delivered]
  validates :status, presence: true, inclusion: { in: statuses.keys }
  scope :completed, -> { where(status: :delivered) }
end