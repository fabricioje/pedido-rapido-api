# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  price       :decimal(10, 2)
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0}
end
