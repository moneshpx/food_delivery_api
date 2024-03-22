require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'john@example.com',password: "123456")
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: "Johna")
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(name: 'John Doe')
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(name: 'John Doe', email: 'john@example.com')
      user = User.new(name: 'Jane Doe', email: 'john@example.com')
      expect(user).not_to be_valid
    end
  end
end