FactoryBot.define do
  factory :order do
    name { "Order" }
    table_numer { Faker::Number.between(from: 1, to: 10)}
    employe
  end
end
