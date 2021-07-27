# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  comment    :text
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :order_item do
    quantity { Faker::Number.between(from: 1, to: 10)}
    comment { Faker::Lorem.paragraph }
    order
    product
  end
end
