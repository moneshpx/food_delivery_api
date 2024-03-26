class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
