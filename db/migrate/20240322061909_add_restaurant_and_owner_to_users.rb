class AddRestaurantAndOwnerToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :restaurant_name, :string
    add_column :users, :owner_name, :string
  end
end
