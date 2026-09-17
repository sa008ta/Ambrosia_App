class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false, default: 0
      t.string :category, null: false
      t.string :image_url
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
