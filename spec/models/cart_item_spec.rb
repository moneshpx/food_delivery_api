require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "CartItem Testcases" do
    it('CartItem with valid attributes') do
      user = User.create(email: "test@gmail.com", password:"123456")
      cart = Cart.create(user_id:user.id)
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      category = Category.create(name: "pizza")
      item = Item.create(name: "pizza",restaurant_id:restaurant.id, category_id:category.id)
      cartitem = CartItem.new(cart_id:cart.id,item_id:item.id,quantity:2)
      expect(cartitem).to be_valid
    end

    it("Cart id must exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      category = Category.create(name: "pizza")
      item = Item.create(name: "pizza",restaurant_id:restaurant.id, category_id:category.id)
      cartitem = CartItem.new(cart_id: 2,item_id:item.id)
      expect(cartitem).not_to be_valid
    end

    it("Item id must exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      cart = Cart.create(user_id:user.id)
      cartitem = CartItem.new(cart_id: cart.id,item_id:2)
      expect(cartitem).not_to be_valid
    end
  end
end
