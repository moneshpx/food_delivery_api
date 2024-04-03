require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Order testcases" do
    it("With valid attributes order") do
      user = User.create(email: "test@gmail.com",password: "123456")
      order = Order.new(user_id:user.id,quantity:2)
      expect(order).to be_valid
    end

    it("User id must exist") do
      order = Order.new(quantity:2)
      expect(order).not_to be_valid
    end

    it "has many order items" do
      association = described_class.reflect_on_association(:order_items)
      expect(association.macro).to eq :has_many
    end

    it "has many items through order items" do
      association = described_class.reflect_on_association(:items)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :order_items
    end

    it "validates presence of status" do
      order = Order.new(user_id: 1, quantity: 2)
      expect(order).not_to be_valid
      expect(order.errors[:status]).to include("can't be blank")
    end

    it "validates inclusion of status in specified enum" do
      order = Order.new(user_id: 1, quantity: 2, status: :invalid_status)
      expect(order).not_to be_valid
      expect(order.errors[:status]).to include("is not included in the list")
    end

    it "scopes completed orders to those with status 'delivered'" do
      delivered_order = Order.create(user_id: 1, quantity: 2, status: :delivered)
      pending_order = Order.create(user_id: 1, quantity: 2, status: :pending)
      completed_orders = Order.completed

      expect(completed_orders).to include(delivered_order)
      expect(completed_orders).not_to include(pending_order)
    end

  end
end