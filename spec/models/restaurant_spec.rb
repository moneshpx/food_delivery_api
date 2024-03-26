require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "Restaurant testcases" do
    it("with valid attributes") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.new(owner_name: "frenkly",user_id:user.id)
      expect(restaurant).to be_valid
    end

    it("Owner name must be exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.new(user_id:user.id)
      expect(restaurant).not_to be_valid
    end

    it("User must be exist") do
      user = User.create(email: "test@gmail.com", password:"123456")
      restaurant = Restaurant.new(owner_name: "frenkly")
      expect(restaurant).not_to be_valid
    end
  end
end
