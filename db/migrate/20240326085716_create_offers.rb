class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :title
      t.integer :fixed_discount
      t.integer :percentage_discount
      t.string :code
      t.text :detail
      t.date :valid_from
      t.date :valid_until
      t.references :restaurant, null: false, foreign_key: true
      t.references :item, null: true, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.timestamps
    end
  end
end
