class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
