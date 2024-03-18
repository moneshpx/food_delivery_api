class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :street
      t.integer :post_code
      t.string :landmark
      t.string :label
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
