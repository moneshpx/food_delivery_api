class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :image
      t.string :address
      t.string :working_days, array: true, default: [], null: false
      t.datetime :open_time
      t.datetime :close_time
      t.string :documents
      t.text :details
      t.string :owner_name
      t.string :email
      t.integer :mobile_number
      t.references :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
