class Product < ApplicationRecord
  has_many :order_items, dependent: :nullify

  scope :available, -> { where(available: true) }

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
