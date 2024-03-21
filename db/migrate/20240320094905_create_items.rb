class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :detail
      t.decimal :price
      t.string :size
      t.string :image_url
      t.string :ingredints_basic
      t.string :fruits
      t.references :restaurant, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
