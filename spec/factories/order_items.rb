FactoryBot.define do
  factory :order_item do
    quantity { Faker::Number.between(from: 1, to: 10)}
    comment { Faker::Lorem.paragraph }
    order
    product
  end
end
