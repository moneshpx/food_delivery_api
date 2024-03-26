require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Category rspec" do
    it("create category") do
      category = Category.new(name: "pizza")
      expect(category).to be_valid 
    end

    it("Category name must be exist") do
      category = Category.new()
      expect(category).to_not be_valid
    end
  end
end
