class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :detail
      t.decimal :price
      t.string :size
      t.string :image_url
      t.text :ingredients_basic, array: true, default: [] 
      t.text :fruits, array: true, default: [] 

      t.timestamps
    end
  end
end
