# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  order_id   :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :order_item do
    quantity { Faker::Number.between(from: 1, to: 10)}
    comment { Faker::Lorem.paragraph }
    order
    product
  end
end
