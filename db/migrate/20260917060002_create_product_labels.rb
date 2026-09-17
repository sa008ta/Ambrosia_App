class CreateProductLabels < ActiveRecord::Migration[8.1]
  def change
    create_table :product_labels do |t|
      t.references :product, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end

    add_index :product_labels, [:product_id, :label_id], unique: true
  end
end
