class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items
  
  # Calculate total price of all items in the cart
  def calculate_total_price
    cart_items.sum(&:subtotal)
  end
end
