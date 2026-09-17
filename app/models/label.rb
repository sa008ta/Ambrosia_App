class Label < ApplicationRecord
  has_many :product_labels, dependent: :destroy
  has_many :products, through: :product_labels

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
