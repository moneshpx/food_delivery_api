class User < ApplicationRecord
  has_many :foods
  has_many :addresses
  has_many :restaurants
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
