require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Item Testcases" do
    it("Item with valid attributes") do
      user = User.create(email: "test@gmail.com", password:"123456")
      category =  Category.create(name:"pizza")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      item = Item.new(name: "pizza",restaurant_id:restaurant.id, category_id:category.id)
      expect(item).to be_valid
    end

    it("name must exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      category =  Category.create(name:"pizza")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      item = Item.new(restaurant_id:restaurant.id, category_id:category.id) 
      expect(item).not_to be_valid
    end

    it("Category must exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      item = Item.new(name: "pizza",restaurant_id:restaurant.id)
      expect(item).not_to be_valid
    end

    it("Restaurant must be exist") do
      category =  Category.create(name:"pizza")
      item = Item.new(name: "pizza", category_id:category.id)
      expect(item).not_to be_valid
    end
  end
end
