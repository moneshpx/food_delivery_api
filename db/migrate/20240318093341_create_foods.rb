class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :detail
      t.decimal :price
      t.string :image_url
      t.string :ingredints_basic
      t.string :fruits
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
