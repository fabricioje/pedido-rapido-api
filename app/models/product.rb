class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0}
end
