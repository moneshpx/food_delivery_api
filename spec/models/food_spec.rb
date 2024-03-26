require 'rails_helper'

RSpec.describe Food, type: :model do
  describe "Food" do
    it("Food with valid attributes") do
      user = User.create(email: "test@gmail.com",password: "123456")
      food = Food.new(name: "french fries",user_id: user.id)
      expect(food).to be_valid
    end

    it("Food name must be exist") do
      user = User.create(email: "test@gmail.com",password: "123456")
      food = Food.new(user_id: user.id)
      expect(food).not_to be_valid
    end

    it("User must be exist") do
      food = Food.new(name: "test fruit")
      expect(food).not_to be_valid
    end
  end
end
