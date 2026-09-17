class Product < ApplicationRecord
  has_many :order_items, dependent: :nullify

  scope :available, -> { where(available: true) }

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def sold_out?
    stock_quantity.to_i <= 0
  end

  def status_label
    sold_out? ? "売り切れ" : "販売中"
  end
end
