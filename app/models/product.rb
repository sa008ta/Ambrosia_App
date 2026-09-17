class Product < ApplicationRecord
  has_many :order_items, dependent: :nullify
  has_many :product_labels, dependent: :destroy
  has_many :labels, through: :product_labels
  has_one_attached :image

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

  def label_names
    labels.order(:position, :id).pluck(:name)
  end

  def label_names_text
    names = label_names
    names.any? ? names.join(" / ") : category
  end
end
