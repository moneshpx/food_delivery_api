require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Review Rspec' do
    it("Review valid attributes") do
      user = User.create(email: "test@gmail.com", password: "123456")
      review = Review.new(rating:4,user_id:user.id)
      expect(review).to be_valid
    end

    it("User must exist")do
      review = Review.new(rating:3)
      expect(review).not_to be_valid
    end

    it("Rating must exist") do
      user = User.create(email: "test@gmail.com", password: "123456")
      review = Review.new(user_id:user.id)
      expect(review).not_to be_valid
    end
  end
end
