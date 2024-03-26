class Category < ApplicationRecord
	has_many :items, dependent: :destroy
	has_many :offers, dependent: :destroy
	validates :name, presence: true
end
