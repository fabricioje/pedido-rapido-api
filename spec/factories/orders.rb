# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  name        :string
#  table_numer :string
#  employe_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string
#  delete_at   :datetime
#
FactoryBot.define do
  factory :order do
    name { "Order" }
    table_numer { Faker::Number.between(from: 1, to: 10)}
    employe
  end
end
