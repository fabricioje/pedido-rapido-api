class Order < ApplicationRecord
  belongs_to :employe
  has_many :order_items, dependent: :destroy

  validates :table_numer, presence: true
end
