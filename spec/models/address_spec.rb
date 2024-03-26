require 'rails_helper'
RSpec.describe Address, type: :model do
  describe 'validations' do
    it("Address with name") do
      user = User.create(email: "san@gmail.com", password: "123456")
      address = Address.new(address: "Sen tiago",user_id:user.id)
      expect(address).to be_valid
    end

    it("Address must be exist") do
      user = User.create(email: "san@gmail.com", password: "123456")
      address = Address.new(user_id:user.id)
      expect(address).not_to be_valid
    end

    it("User must be exist") do
      address = Address.new(address: "12 haidrabad")
      expect(address).not_to be_valid
    end
  end
end
