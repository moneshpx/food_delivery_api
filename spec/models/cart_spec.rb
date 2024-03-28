require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "Cart Testcases" do
    it "Cart with valid attributes" do
      user = User.create(email:"test@gmail.com",password:"123456")
      cart = Cart.new(user_id:user.id)
      expect(cart).to be_valid
    end

    it "User id must exist" do
      user = User.create(email:"test@gmail.com",password:"123456")
      cart = Cart.new()
      expect(cart).not_to be_valid
    end
  end
end
