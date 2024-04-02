class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  enum status: [:pending, :ongoing, :shipped, :delivered]

  scope :completed, -> { where(status: :delivered) }

  after_create :set_ongoing_status

  private

  def set_ongoing_status
    self.update(status: "ongoing")
  end
end