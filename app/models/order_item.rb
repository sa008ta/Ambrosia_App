class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :product_name, presence: true
  validates :product_category, presence: true

  def status_label
    provided? ? "提供済み" : "未提供"
  end
end
