# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  delete_at   :datetime
#  name        :string
#  status      :string
#  table_numer :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint           not null
#
# Indexes
#
#  index_orders_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
FactoryBot.define do
  factory :order do
    name { "Order" }
    table_numer { Faker::Number.between(from: 1, to: 10) }
    employee
  end
end
