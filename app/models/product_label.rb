class ProductLabel < ApplicationRecord
  belongs_to :product
  belongs_to :label

  validates :product_id, uniqueness: { scope: :label_id }
end
