class Category < ApplicationRecord
	has_many :items, dependent: :destroy
	has_many :offers, dependent: :destroy
	validates :name, presence: true
	before_create :downcase_name
	private

  def downcase_name
    self.name = name.downcase
  end
end
