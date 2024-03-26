require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe "Offer testcases" do
    it("Offer with valid attributes") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      offer = Offer.new(title: "testi samosa",restaurant_id: restaurant.id)
      expect(offer).to be_valid
    end

    it("Owner name must be exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      offer = Offer.new(restaurant_id: restaurant.id)
      expect(offer).not_to be_valid
    end

    it("Restaurant must be exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.create(owner_name:"test rastaurant",user_id: user.id)
      offer = Offer.new(title: "testi samosa")
      expect(offer).not_to be_valid
    end
  end
end
