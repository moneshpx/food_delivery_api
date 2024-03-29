class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  before_save :calculate_subtotal
  validates :quantity, presence: true

  private
  def calculate_subtotal
    self.subtotal = quantity * unit_price
  end
end
