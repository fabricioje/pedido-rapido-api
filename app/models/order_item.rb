class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0}
  validates :quantity, presence: true, numericality: { greater_than: 0}
  validates :product_id, presence: true
  validates :order_id, presence: true
end