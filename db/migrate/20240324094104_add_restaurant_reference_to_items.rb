class AddRestaurantReferenceToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :restaurant, null: false, foreign_key: true
    add_reference :items, :category, null: false, foreign_key: true
  end
end
