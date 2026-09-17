class BackfillLabelsFromProducts < ActiveRecord::Migration[8.1]
  class Product < ApplicationRecord
    self.table_name = "products"
  end

  class Label < ApplicationRecord
    self.table_name = "labels"
  end

  class ProductLabel < ApplicationRecord
    self.table_name = "product_labels"
  end

  def up
    Product.reset_column_information
    Label.reset_column_information

    Product.where.not(category: [nil, ""]).distinct.pluck(:category).sort.each_with_index do |category, index|
      Label.find_or_create_by!(name: category) do |label|
        label.position = index + 1
      end
    end

    Product.where.not(category: [nil, ""]).find_each do |product|
      label = Label.find_by(name: product.category)
      next unless label

      ProductLabel.find_or_create_by!(product_id: product.id, label_id: label.id)
    end
  end

  def down
    ProductLabel.delete_all
    Label.delete_all
  end
end
