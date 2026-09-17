class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: true, foreign_key: { on_delete: :nullify }
      t.integer :quantity, null: false, default: 1
      t.integer :unit_price, null: false, default: 0
      t.string :product_name, null: false
      t.string :product_category, null: false

      t.timestamps
    end
  end
end
