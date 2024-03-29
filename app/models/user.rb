class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart, dependent: :destroy
  has_one :review, dependent: :destroy
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  after_create :create_cart

  private

  def create_cart
    Cart.create(user: self)
  end
end
